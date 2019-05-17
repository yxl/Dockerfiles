#!/bin/sh

hue syncdb --noinput
hue migrate
supervisor
