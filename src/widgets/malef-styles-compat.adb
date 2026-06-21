-------------------------------------------------------------------------------
--                                                                           --
--               M A L E F - S T Y L E S - C O M P A T . A D B               --
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
with Malef.Palettes;

package body Malef.Styles.Compat is

   function Make_Style return Malef.Styles.Sheets.Style_Sheet is
      package S renames Malef.Styles;
      package P renames Malef.Palettes;
      Sheet : S.Sheets.Style_Sheet := S.Sheets.Empty;
      App   : S.Style              := S.Empty;
      Dlg   : S.Style              := S.Empty;
   begin
      S.Set (App, S.Background, P.Default_Palette (P.Green)'Image);
      S.Set (App, S.Foreground, P.Default_Palette (P.Black)'Image);
      S.Sheets.Insert (Sheet, "Application", App);

      S.Set (Dlg, S.Background,        P.Default_Palette (P.White)'Image);
      S.Set (Dlg, S.Foreground,        P.Default_Palette (P.Black)'Image);
      S.Set (Dlg, S.Border_Background, P.Default_Palette (P.White)'Image);
      S.Set (Dlg, S.Border_Foreground, P.Default_Palette (P.Black)'Image);
      S.Set (Dlg, S.Border_Thickness,  "Thin");
      S.Set (Dlg, S.Border_Style,      "Square");
      S.Sheets.Insert (Sheet, "Dialog", Dlg);

      return Sheet;
   end Make_Style;

begin
   Style := Make_Style;
end Malef.Styles.Compat;
