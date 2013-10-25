with Ada.Text_IO; use Ada.Text_IO;
with Dessin; use Dessin;
with Ligne; use Ligne;
with STL ; use STL;
with Algebre ; use Algebre;

with Scene; use Scene;

package body Frame is
    procedure Calcul_Image is
        P1, P2, P3 : Vecteur(1..2);
        Nb_Facette:Natural:=0;
    begin

        -- On nettoie l'écran de l'affichage précédent en réinitialisant tous les pixels au noir
        for i in 1..SCRH loop
            for j in 1..SCRW loop
                Fixe_Pixel(j,i,0);
            end loop;
        end loop;
        -- Après avoir déterminé le nombre de facettes à afficher, on itère sur le maillage pour calculer les projections et afficher les triangles.
        Nb_Facette:=Nombre_De_Facettes;
        for i in 1..Nb_Facette loop
            Projection_Facette(i, P1, P2, P3);

            Tracer_Segment(Integer(P1(1)), Integer(P1(2)), Integer(P2(1)), Integer(P2(2)));
            Tracer_Segment(Integer(P1(1)), Integer(P1(2)), Integer(P2(1)), Integer(P2(2)));
            Tracer_Segment(Integer(P2(1)), Integer(P2(2)), Integer(P3(1)), Integer(P3(2)));
        end loop;
    end ;
end Frame;
