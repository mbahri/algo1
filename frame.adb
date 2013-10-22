with Dessin; use Dessin;
with Ligne; use Ligne;
with STL ; use STL;
with Algebre ; use Algebre;

with Scene;

package body Frame is

    procedure Calcul_Image is
        P1, P2, P3 : Vecteur(1..2);
        Nb_Facette:Natural:=0;
    begin
        -- a faire : calcul des projections, affichage des triangles
        Nb_Facette:=Nombre_De_Facettes;
        for i in 1..Nb_Facette loop
            Projection_Facette(i, P1, P2, P3);
            Tracer_Segment(P1(1), P1(2), P2(1), P2(2));
            Tracer_Segment(P1(1), P1(2), P2(1), P2(2));
            Tracer_Segment(P2(1), P2(2), P3(1), P3(2));
        end loop;
        null;
    end;

end Frame;
