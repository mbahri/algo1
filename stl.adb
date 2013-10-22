with Algebre;
use Algebre;

with Ada.Text_IO;
use Ada.Text_IO;

-- On utilise des chaines de longueur variable pour le traitement des lignes
with Ada.Strings.Unbounded;

package body STL is

    -- On pourra utiliser le package Ada.Strings.Unbounded sous le nom U
    package U renames Ada.Strings.Unbounded;

    function Nombre_Facettes(Nom_Fichier : String) return Natural is
        F : File_Type;
        Nb : Natural := 0;
        Line_epuree : U.Unbounded_String := U.Null_Unbounded_String;
    begin
        Open(File => F, Mode => In_File, Name => Nom_Fichier);
        -- Fonctionnement du comptage : on compte les endfacet
        -- On lit le fichier ligne par ligne, pour chaque ligne on supprime tous les caractères qui ne sont pas
        -- des lettres minuscules.
        -- On recopie pour cela tous les caractères différents de ' ' dans une Unbounded_String.
        -- ANCIENNE VERSION : Pour ce faire, on crée une copie de la ligne et on écrase les caractères en partant du début.
        -- On compare ensuite la partie de la chaine correspondant à la ligne épurée : ce sont les "cpt" premiers caractères.
        -- --

        while not End_of_File(F) loop
            declare
                Line : String := Get_Line(File);
                cpt : Natural := 1;
            begin
                Line_epuree := U.Null_Unbounded_String;

                for i in Line'Range loop
                     if Line(i) /= ' ' then
                         U.Append(Source => Line_epuree, New_Item => Line(i));
                         cpt := cpt + 1;
                     end if;
                end loop;

                if U.To_String(Line_epuree) = "endfacet" then
                    Nb := Nb + 1;
                end if;
            end;
        end loop;
        Close(F);
        return Nb;
    end;


    function Parse_ligne(Ligne : in String) return Vecteur is
        Facette : Vecteur(1..3);
        Pos : Positive := 1;
        CarCour : Character := Ligne(1);

        Buffer : U.Unbounded_String := U.Null_Unbounded_String;

        procedure AvCar is
        begin
            Pos := Pos + 1;
            CarCour := Ligne(Pos);
        end;

        function Lire6 return String is
        begin
            Buffer := U.Null_Unbounded_String;
            for I in 1..6 loop
                U.Append(Source => Buffer, New_Item => CarCour);
                AvCar;
            end loop;

            return U.To_String(Buffer);
        end;

        -- On saute les espaces
        procedure NextV is
        begin
            while CarCour /= 'v' loop
                AvCar;
            end loop;
        end;

    begin
        NextV;
        -- On arrive sur un v, il faut voir si on a "vertex"
        if Lire6 = "vertex" then
            -- On se trouve sur le 'x' de vertex, on va avancer d'un caractère puis lire 3 float
            AvCar;
            for I in 1..3 loop
                Buffer := U.Null_Unbounded_String;
                AvCar;
                while CarCour /= ' ' loop
                    U.Append(Source => Buffer, New_Item => CarCour);
                end loop;
                    Facette(I) := Float'Value(U.To_String(Buffer));
                end loop;
        else
            NextV;
        end if;

        return Facette;
    end;

    function Chargement_ASCII(Nom_Fichier : String) return Maillage is
        Nb_Facettes : Natural;
        M : Maillage;
        F : File_Type;
        Facette : Vecteur(1..3);
        Pos : Positive := 1;
    begin
        Nb_Facettes := Nombre_Facettes(Nom_Fichier);
        -- une fois qu'on a le nombre de facettes on connait la taille du maillage
        M := new Tableau_Facette(1..Nb_Facettes);
        -- on ouvre de nouveau le fichier pour parcourir les facettes
        -- et remplir le maillage
        Open(File => F, Mode => In_File, Name => Nom_Fichier);
        while not End_of_File(F) loop
            declare
                Ligne : String := Get_Line(F);
            begin
                Facette := Parse_Ligne(Ligne);
                M(Pos) := Facette;
                Pos := Pos + 1;
            end;
        end loop;
        Close (F);
        return M;
    end;

end;
