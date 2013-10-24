with Dessin; use Dessin;
with Ligne; use Ligne;
with STL ; use STL;
with Algebre ; use Algebre;

with Scene; use Scene;

package body Frame is

    procedure Tracer_Segment_Secu(X1, Y1, X2, Y2 : in out Natural) is
        P : Float := 0.0;
    begin
        if (X1 in 1..SCRW) and then (Y1 in 1..SCRH) and then (X2 in 1..SCRW) and then (Y2 in 1..SCRH) then
            Trace_Segment(X1,Y1,X2,Y2);
        else
            P := Float((Y2 - Y1))/Float(abs (X2 - X1));
            if not (X1 in 1..SCRW) or else not (Y1 in 1..SCRH) then

            if not (X2 in 1..SCRW) or else not (Y2 in 1..SCRH) then
    end;

    procedure Calcul_Image is
        P1, P2, P3 : Vecteur(1..2);
        Nb_Facette:Natural:=0;
    begin

        -- on nettoit l'écran de l'affichage précédent en réinitialisant tous les pixels au noir
        for i in 1..SCRH loop
            for j in 1..SCRW loop
                Fixe_Pixel(j,i,0);
            end loop;
        end loop;
        -- a faire : calcul des projections, affichage des triangles
        Nb_Facette:=Nombre_De_Facettes;
        for i in 1..Nb_Facette loop
            Projection_Facette(i, P1, P2, P3);
            
            Tracer_Segment_Secu(Natural(P1(1)), Natural(P1(2)), Natural(P2(1)), Natural(P2(2)));
            Tracer_Segment_Secu(Natural(P1(1)), Natural(P1(2)), Natural(P2(1)), Natural(P2(2)));
            Tracer_Segment_Secu(Natural(P2(1)), Natural(P2(2)), Natural(P3(1)), Natural(P3(2)));
        end loop;
    exception
        when CONSTRAINT_ERROR =>
            null;
    end ;
end Frame;
