
with Ada.Text_IO;
use Ada.Text_IO;

package body STL is

    function Nombre_Facettes(Nom_Fichier : String) return Natural is
        F : File_Type;
        Nb : Natural := 0;
    begin
        Open(File => F, Mode => In_File, Name => Nom_Fichier);
        -- Fonctionnement du comptage : on compte les endfacet
        -- On lit le fichier ligne par ligne, pour chaque ligne on supprime tous les caractères qui ne sont pas
        -- des lettres minuscules.
        -- Pour ce faire, on crée une copie de la ligne et on écrase les caractères en partant du début.
        -- On compare ensuite la partie de la chaine correspondant à la ligne épurée : ce sont les "cpt" premiers caractères.

        while not End_of_File(F) loop
            declare
                Line : String := Get_Line(File);
                Line_epuree : String := Line;
                cpt : Natural := 1;
            begin
                for i in Line'Range loop
                    if Line(i) in 'a'..'z' then
                        Line_epuree(cpt) := Line(i);
                        cpt := cpt + 1;
                    end if;
                end loop;

                if Line_epuree(Line_epuree'First .. (cpt-1)) = "endfacet" then
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
    begin
        Nb_Facettes := Nombre_Facettes(Nom_Fichier);
        -- une fois qu'on a le nombre de facettes on connait la taille du maillage
        M := new Tableau_Facette(1..Nb_Facettes);
        -- on ouvre de nouveau le fichier pour parcourir les facettes
        -- et remplir le maillage
        Open(File => F, Mode => In_File, Name => Nom_Fichier);
        -- a faire...
        Close (F);
        return M;
    end;

end;
