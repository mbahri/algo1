with Algebre;
use Algebre;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Float_Text_IO; use Ada.Float_Text_IO;

-- On utilise des chaines de longueur variable pour le traitement des lignes
with Ada.Strings.Unbounded;

package body STL is

    IFace : Natural := 0;
    Indice : Natural := 0;

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
                Line : String := Get_Line(F);
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

    function Parse_ligne(Ligne : in String) return Facette is
        Face : Facette;
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
                AvCar;
            end loop;
        end;

    begin
        NextV;
        -- On arrive sur un v, il faut voir si on a "vertex"
        if Lire6 = "vertex" then

            Indice := (Indice + 1) mod 3; 
            Put_Line(Integer'Image(Indice));

            -- On se trouve sur le 'x' de vertex, on va avancer d'un caractère puis lire 3 float
            for I in 1..3 loop
                Buffer := U.Null_Unbounded_String;
                AvCar;
                while (Pos <= Ligne'Length) and then (CarCour /= ' ') loop
                   -- Put("Caractère lu dans la boucle : "); Put(CarCour); New_Line; --DEBUG
                    U.Append(Source => Buffer, New_Item => CarCour);
                    AvCar;
                end loop;
                    --Put_Line("Fin float"); --DEBUG
                    -- Ici il y a un problème : les 3 sont remplis alternatives
                    -- Il faut une variable auxilliaire cpt, et à chaque fois que cpt est un multiple de 3, il faut incrémenter le compteur avec un modulo.
                    case Indice is
                        when 1 => Face.P1(I) := Float'Value(U.To_String(Buffer));
                        --          Indice := 2;
                        when 2 => Face.P2(I) := Float'Value(U.To_String(Buffer));
                        --          Indice := 3;
                        when 0 => Face.P3(I) := Float'Value(U.To_String(Buffer));
                        --          Indice := 1;
                        when others => null;
                    end case;
            end loop;
            if Indice = 0 then
              IFace := IFace + 1;
            end if;

        else
            NextV;
        end if;
        return Face;
    end;

    function Chargement_ASCII(Nom_Fichier : String) return Maillage is
        Nb_Facettes : Natural;
        M : Maillage;
        F : File_Type;
        Face : Facette;
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
                Face := Parse_Ligne(Ligne);
                if IFace > 0 then
                    M(IFace) := Face;
                end if;
            end;
        end loop;
        Close (F);
        for I in 1..Nb_Facettes loop
            Put("Facette"); New_Line;
            for J in 1..3 loop
                Put(M(I).P1(J));
            end loop;
            New_Line;
            for J in 1..3 loop
                Put(M(I).P2(J));
            end loop;
            New_Line;
            for J in 1..3 loop
                Put(M(I).P3(J));
            end loop;
            New_Line; Put("Fin_Facette"); New_Line;
        end loop;
        return M;
    end;

end;