#!/usr/bin/env python

from gi.repository import Gtk
import gi
import argparse
gi.require_version("Gtk", "3.0")


class MainWindow:
    def __init__(self):
        self.gladefile = "gtkwindow.glade"
        self.builder = Gtk.Builder()
        self.builder.add_from_file(self.gladefile)
        self.builder.connect_signals(self)

        apply = self.builder.get_object("apply")
        apply.connect("clicked", self.apply_colors)
        close = self.builder.get_object("close")
        close.connect("clicked", Gtk.main_quit)

        self.fg_color1_obj = self.builder.get_object("fg_color1")
        self.fg_color1_obj.connect("color-set", self.pick_fg_color1)
        self.fg_color2_obj = self.builder.get_object("fg_color2")
        self.fg_color2_obj.connect("color-set", self.pick_fg_color2)
        self.bg_color_obj = self.builder.get_object("bg_color")
        self.bg_color_obj.connect("color-set", self.pick_bg_color)

        self.fg_entry1 = self.builder.get_object("fg_entry1")
        self.fg_entry1.connect("changed", self.get_fg_color1)
        self.fg_entry2 = self.builder.get_object("fg_entry2")
        self.fg_entry2.connect("changed", self.get_fg_color2)
        self.bg_entry = self.builder.get_object("bg_entry")
        self.bg_entry.connect("changed", self.get_bg_color)

        window = self.builder.get_object("main_window")
        window.connect("delete-event", Gtk.main_quit)
        window.show_all()

    def rgba_to_hex(self, rgb_color):
        rgba = (rgb_color.strip("rgba()").split(","))
        red = int(rgba[0])
        green = int(rgba[1])
        blue = int(rgba[2])
        try:
            alpha = int(rgba[3])
            return '#{:02x}{:02x}{:02x}{:02x}'.format(red, green, blue, alpha)
        except IndexError:
            return '#{:02x}{:02x}{:02x}'.format(red, green, blue)

    def get_fg_color1(self, widget):
        value = self.fg_entry1.get_text()
        self.fg_color1 = self.rgba_to_hex(value)

    def get_fg_color2(self, widget):
        value = self.fg_entry2.get_text()
        self.fg_color2 = self.rgba_to_hex(value)

    def get_bg_color(self, widget):
        value = self.bg_entry.get_text()
        self.bg_color = self.rgba_to_hex(value)
        print(self.bg_color)

    def pick_fg_color1(self, widget):
        fg_picked1 = self.fg_color1_obj.get_rgba().to_string()
        self.fg_entry1.set_text(fg_picked1)
        self.get_fg_color1(widget)

    def pick_fg_color2(self, widget):
        fg_pickd2 = self.fg_color2_obj.get_rgba().to_string()
        self.fg_entry2.set_text(fg_pickd2)
        self.get_fg_color2(widget)

    def pick_bg_color(self, widget):
        bg_picked = self.bg_color_obj.get_rgba().to_string()
        self.bg_entry.set_text(bg_picked)
        self.get_bg_color(widget)

    def apply_colors(self, widget):
        with open("/home/ted/Carousel/bubbles.ini", "r") as file:
            lines = file.readlines()
            line = next(line for line in lines if "shade1 = " in line)
            pos = lines.index(line)
            lines.remove(line)
            lines.insert(pos, f"shade1 = {self.fg_color1}\n")

            line = next(line for line in lines if "shade2 = " in line)
            pos = lines.index(line)
            lines.remove(line)
            lines.insert(pos, f"shade2 = {self.fg_color2}\n")

            line = next(line for line in lines if "background = " in line)
            pos = lines.index(line)
            lines.remove(line)
            lines.insert(pos, f"background = {self.bg_color}\n")

        with open("/home/ted/Carousel/bubbles.ini", "w") as file:
            file.writelines(lines)


if __name__ == "__main__":
    main = MainWindow()
    Gtk.main()
