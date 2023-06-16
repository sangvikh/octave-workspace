## Copyright (C) 2019 Harald Sangvik
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} drawCircle (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Harald Sangvik <sangvikh@sangvikh-Multicom-U230>
## Created: 2019-03-24

function [retval] = drawCircle (r, x, y, scale = 1)

a = linspace(0,2*pi(),100);
plot(scale*(r*cos(a)+x),scale*(r*sin(a)+y));
axis equal;
hold on;
drawnow;

endfunction
