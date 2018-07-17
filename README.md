# ICESL-TOOLS

This is a library of useful geometric functions for use with ICE-SL parametric modeller
and slicer (used for 3d printing)

## caviets

This is my first foray into LUA and as such, might result in some
horrible quality code. I would welcome assistance/criticism (constructive)
with respect to the code and LUA itself. Specifically using modules to namespace
this code so as to not pollute the namespace of other libraries.

## utilities

A set of useful functions.

### mergeTables

Allows the merging of multiple tables, generally used to set default values.

## roundedBox

A function for the generation of arbitrary rectangular figures with rounded edges.
It supports the ability to define the radius of the edges and which sides are rounded
and which are flat.