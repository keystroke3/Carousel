"""
 Copyright 2016 KDE Connect Indicator Developers
 *
 * This software is licensed under the GNU Lesser General Public License
 * (version 2.1 or later).  See the COPYING file in this distribution.
"""

import gi
gi.require_version('Caja', '3.0')
gi.require_version('Notify', '0.7')
gi.require_version('Gio', '2.0')
gi.require_version('GLib', '2.0')
gi.require_version('GObject', '2.0')
from gi.repository import Caja, GObject, Notify, Gio, GLib
from subprocess import Popen
from os.path import isfile
import urllib, gettext, locale

# use of _ to set messages to be translated
_ = gettext.gettext
timeout = 350

class SendViaExtension(GObject.GObject, Caja.MenuProvider):

    def __init__(self):
	    GObject.GObject.__init__(self)

        self.dbus = Gio.DBusProxy.new_for_bus_sync(
            Gio.BusType.SESSION,
            Gio.DBusProxyFlags.NONE,
            None,
            'org.kde.kdeconnect',
            '/modules/kdeconnect',
            'org.kde.kdeconnect.daemon',
            None)   

    """Inicialize translations to a domain"""
    def setup_gettext(self):
        try:
            locale.setlocale(locale.LC_ALL, "")
            gettext.bindtextdomain("indicator-kdeconnect", "/usr/share/locale")
            gettext.textdomain("indicator-kdeconnect")
        except:
            pass

    """Get a list of reachable devices"""
    def get_reachable_devices(self):
        try:
            onlyReachable = True             
            onlyPaired = True        
            variant = GLib.Variant('(bb)', (onlyReachable, onlyPaired))                        
            devices = self.dbus.call_sync('deviceNames', variant, 0, -1, None)                    
            devices = devices.unpack()[0]            
            return devices
        except Exception as e:
            raise Exception(e)        

    """Send a files with kdeconnect dbus"""
    def send_files(self, menu, files, device_id, device_name):
        device_proxy = Gio.DBusProxy.new_for_bus_sync(
            Gio.BusType.SESSION,
            Gio.DBusProxyFlags.NONE,
            None,
            'org.kde.kdeconnect',
            '/modules/kdeconnect/devices/'+device_id+'/share',
            'org.kde.kdeconnect.device.share',
            None)

        for file in files:
            variant = GLib.Variant('(s)', (file.get_uri(),))
            device_proxy.call_sync('shareUrl', variant, 0, timeout, None)

        self.setup_gettext()
        Notify.init("KDEConnect-send")
        Notify.Notification.new(_("Check the device {device_name}").format(device_name=device_name),
                                _("Sending {num_files} file(s)").format(num_files=len(files))).show()

    """Open Multiple Send Window"""
    def send_to_multiple_devices(self, menu, files):
        args = []
        args.append("kdeconnect-send")

        for file in files:
            args.append(urllib.unquote(file.get_uri()[7:]))
                
        Popen(args)

    """Send selected files"""
    def menu_activate_cb(self, menu, files, device_id, device_name):
        self.send_files(files, device_id, device_name)

    """Get files that user selected"""
    def get_file_items(self, window, files):
        """Ensure there are reachable devices"""
        try:
            devices = self.get_reachable_devices()
        except Exception as e:
            raise Exception("Error while getting reachable devices")

        """if there is no reacheable devices don't show this on context menu"""
        if len(devices) == 0:
            return

        """Ensure that user only select files"""
        for file in files:
            if file.get_uri_scheme() != 'file' or file.is_directory():
                return

        self.setup_gettext()
        """If user only select file(s) create menu and sub menu"""
        menu = Caja.MenuItem(name = 'SendViaExtension::SendViaKDEConnect',
                             label = _('KDEConnect Send To'),
                             tip = _('send file(s) with kdeconnect'),
                             icon = 'kdeconnect')

        sub_menu = CajaMenu()

        menu.set_submenu(sub_menu)

        for deviceId, deviceName in devices.items():
            item = Caja.MenuItem(name='SendViaExtension::SendFileTo'+deviceId,
                                 label=deviceName)
            item.connect('activate', self.send_files, files, deviceId, deviceName)
            sub_menu.append_item(item)

        if len(devices) > 1:
            item = Caja.MenuItem(name='SendViaExtension::SendFileToMultipleDevices',
            			         label='Multiple Devices')
            item.connect('activate', self.send_to_multiple_devices, files)
     	
            sub_menu.append_item(item)
        
        return menu
