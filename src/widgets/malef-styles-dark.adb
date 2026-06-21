-------------------------------------------------------------------------------
--                                                                           --
--                 M A L E F - S T Y L E S - D A R K . A D B                 --
--                                                                           --
--                                 M A L E F                                 --
--                                                                           --
--                              A D A   B O D Y                              --
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
-- This  program  is distributed  in the  hope  that it will  be  useful, but --
-- WITHOUT   ANY   WARRANTY;   without   even  the   implied   warranty   of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General --
-- Public License for more details.                                          --
--                                                                           --
-- You should have received  a copy of the  GNU General Public License along --
-- with this program. If not, see <https://www.gnu.org/licenses/>.           --
--                                                                           --
-------------------------------------------------------------------------------

--  This body works around a GNAT 15.0.1 (prerelease) frontend bug: the Ada
--  2022 container aggregate used upstream to initialize Style triggers a stack
--  overflow during analysis.  The sheet is built here with the ordinary
--  Empty / Set / Insert primitives, yielding the same value without invoking
--  the aggregate aspect machinery.
--
--  The assignment lives in the body's statement part (not a deferred
--  constant) so Make_Style is elaborated before it is called: a deferred
--  constant completed by a function in a separate body raises Program_Error
--  at run time (access before elaboration), and GNAT forbids a statement-only
--  body when the spec declares nothing bodyable -- hence Make_Style is
--  declared privately in the spec.

with Malef.Styles.Sheets;

package body Malef.Styles.Dark is

   function Make_Style return Malef.Styles.Sheets.Style_Sheet is
      package S renames Malef.Styles;
      Item  : S.Style             := S.Empty;
      Sheet : S.Sheets.Style_Sheet := S.Sheets.Empty;
   begin
      S.Set (Item, S.Background,       "#33FF00");
      S.Set (Item, S.Foreground,       "#00FF33");
      S.Set (Item, S.Border_Thickness, "Thick");
      S.Sheets.Insert (Sheet, "dialog", Item);
      return Sheet;
   end Make_Style;

begin
   Style := Make_Style;
end Malef.Styles.Dark;
