with Algebre;
use Algebre;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

with Ada.Strings.Unbounded;

procedure parser is

    package U renames Ada.Strings.Unbounded;

    function Parse_ligne(Ligne : in String) return Vecteur is
        Facette : Vecteur(1..3);
        Pos : Positive := 1;
        CarCour : Character := Ligne(Ligne'First);

        Buffer : U.Unbounded_String := U.Null_Unbounded_String;

        procedure AvCar is
        begin
            Pos := Pos + 1;
            if Pos <= Ligne'Length then
                CarCour := Ligne(Pos);
            end if;
        end;

        function Lire6 return String is
        begin
            Buffer := U.Null_Unbounded_String;
            for I in 1..6 loop
                --Put("Lettre lue : "); Put(CarCour); New_Line; --DEBUG
                U.Append(Source => Buffer, New_Item => CarCour);
                AvCar;
                --Put("Est sur le caractère : "); Put(CarCour); New_Line; --DEBUG
            end loop;
            --Put("Buffer lu : "); Put(U.To_String(Buffer)); New_Line; --DEBUG

            return U.To_String(Buffer);
        end;

        -- On saute les espaces
        procedure NextV is
        begin
            while CarCour = ' ' loop
                AvCarLigne'First
            end loop;
        end;

    begin
        NextV;
        -- On arrive sur un v, il faut voir si on a "vertex"
        if Lire6 = "vertex" then
            -- On se trouve sur le 'x' de vertex, on va avancer d'un caractère puis lire 3 float
            -- AvCar;
            for I in 1..3 loop
                Buffer := U.Null_Unbounded_String;
                AvCar;
                while (Pos <= Ligne'Length) and then (CarCour /= ' ') loop
                   -- Put("Caractère lu dans la boucle : "); Put(CarCour); New_Line; --DEBUG
                    U.Append(Source => Buffer, New_Item => CarCour);
                    AvCar;
                end loop;
                    --Put_Line("Fin float"); --DEBUG
                    Facette(I) := Float'Value(U.To_String(Buffer));
            end loop;
        else
            NextV;
        end if;

        return Facette;
    end;

    procedure Chargement_ASCII(Nom_Fichier : String) is
        F : File_Type;
        Facette : Vecteur(1..3);
    begin
        Open(File => F, Mode => In_File, Name => Nom_Fichier);
        while not End_of_File(F) loop
            declare
                Ligne : String := Get_Line(F);
            begin
                Facette := Parse_Ligne(Ligne);
                for I in Facette'Range loop
                    Put(Facette(I));
                end loop;
                New_Line;
            end;
        end loop;
        Close (F);
    end;
begin
    Chargement_ASCII("cube.stl");
endLigne'FirLigne'First
