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

        -- on nettoit l'écran de l'affichage précédent en réinitialisant tous les pixels au noir
        for i in 1..600 loop
            for j in 1..800 loop
                Fixe_Pixel(j,i,0);
            end loop;
        end loop;
        -- a faire : calcul des projections, affichage des triangles
        Nb_Facette:=Nombre_De_Facettes;
        for i in 1..Nb_Facette loop
            Projection_Facette(i, P1, P2, P3);
            
            Tracer_Segment(Natural(P1(1)), Natural(P1(2)), Natural(P2(1)), Natural(P2(2)));
            Tracer_Segment(Natural(P1(1)), Natural(P1(2)), Natural(P2(1)), Natural(P2(2)));
            Tracer_Segment(Natural(P2(1)), Natural(P2(2)), Natural(P3(1)), Natural(P3(2)));
        end loop;
        null;
    end;

end Frame;
