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

    function Chargement_ASCII(Nom_Fichier : String) return Maillage is
        Nb_Facettes : Natural;
        M : Maillage;
        F : File_Type;
        T : Float;
        C : Character;
        Point : Natural := 0;
        iFace : Positive := 1;
    begin
        Nb_Facettes := Nombre_Facettes(Nom_Fichier);
        -- une fois qu'on a le nombre de facettes on connait la taille du maillage
        M := new Tableau_Facette(1..Nb_Facettes);
        -- on ouvre de nouveau le fichier pour parcourir les facettes
        -- et remplir le maillage
        Open(File => F, Mode => In_File, Name => Nom_Fichier);

        -- On saute la première ligne qui pourrait contenir un v
        Skip_Line(F); 

        -- Méthode : on cherche les v, une fois atteint on se place sur le prochain espace
        -- On lit ensuite les 3 prochains flottants
        --
        -- On affecte ensuite les 3 flottants au bon vecteur de la facette à l'aide de "Point" qui
        -- prend circulairement des valeurs entre 0 et 2.
        --
        -- iFace est l'indice de la facette en cours de traitement dans le maillage. On l'incrémente
        -- chaque fois qu'on finit de remplir le 3eme vecteur d'une facette.
        --
        -- À faire : vérifier que le v lu correspond bien à "vertex"
        while not End_of_File(F) loop
            Get(F, C);
            if C = 'v' then
                -- v trouvé : on va traiter le point suivant de la facette
                Point := (Point + 1) mod 3; 
                while not (C = ' ') loop
                    Get(F,C);
                end loop;
                for I in 1..3 loop
                    Get(F, T); -- On lit 3 flottants qu'on affecte au bon vecteur grace à Point
                    case Point is
                        when 1 => M(iFace).P1(I) := T;
                        when 2 => M(iFace).P2(I) := T;
                        when 0 => M(iFace).P3(I) := T; 
                        when others => null;
                    end case;
                end loop;
                if Point = 0 then
                    -- On a fini de remplir un vecteur, s'il s'agissait du 3eme d'une facette, on passe à la facette suivante
                    iFace := iFace + 1;
                end if;
            end if;
        end loop;

        Close (F);
        -- Différents tests d'affichage
--        for I in 1..Nb_Facettes loop
--            Put("Facette"); New_Line;
--            for J in 1..3 loop
--                Put(M(I).P1(J));
--            end loop;
--            New_Line;
--            for J in 1..3 loop
--                Put(M(I).P2(J));
--            end loop;
--            New_Line;
--            for J in 1..3 loop
--                Put(M(I).P3(J));
--            end loop;
--            New_Line; Put("Fin_Facette"); New_Line;
--        end loop;
        return M;
    end;

end;
