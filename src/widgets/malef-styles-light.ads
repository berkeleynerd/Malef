-------------------------------------------------------------------------------
--                                                                           --
--                M A L E F - S T Y L E S - L I G H T . A D S                --
--                                                                           --
--                                 M A L E F                                 --
--                                                                           --
--                              A D A   S P E C                              --
--                                                                           --
-------------------------------------------------------------------------------
--  Copyright (c) 2021-2024 José Antonio Verde Jiménez  All Rights Reserved  --
-------------------------------------------------------------------------------
-- This file is part of Malef.                                               --
--                                                                           --
-- This program is free software:  you  can redistribute it and/or modify it --
-- under  the terms  of the  GNU  General License  as published by the  Free --
-- Software  Foundation,  either  version 3  of  the  License,  or  (at your --
-- opinion) any later version.                                               --
--                                                                           --
-- This  program  is distributed  in the  hope that  it will be  useful, but --
-- WITHOUT   ANY   WARRANTY;   without   even  the   implied   warranty   of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General --
-- Public License for more details.                                          --
--                                                                           --
-- You should have received  a copy of the  GNU General Public License along --
-- with this program. If not, see <https://www.gnu.org/licenses/>.           --
--                                                                           --
-------------------------------------------------------------------------------

with Malef.Styles.Sheets;

package Malef.Styles.Light is

   pragma Elaborate_Body;

   --  Default light style sheet.
   --
   --  Upstream declares this as an Ada 2022 container aggregate constant, but
   --  GNAT 15.0.1 (prerelease) hits a frontend stack overflow while analyzing
   --  that aggregate.  It is therefore a (non-constant) package object that
   --  the body populates during its own elaboration (see malef-styles-light.adb
   --  for why a deferred constant was not viable); the public name and access
   --  syntax are otherwise unchanged.  Restore the upstream aggregate +
   --  'constant' once a GNAT release without the bug is in use.
   Style : Sheets.Style_Sheet;

private

   function Make_Style return Sheets.Style_Sheet;

end Malef.Styles.Light;
