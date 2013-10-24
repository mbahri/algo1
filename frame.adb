with Dessin; use Dessin;
with Ligne; use Ligne;
with STL ; use STL;
with Algebre ; use Algebre;

with Scene; use Scene;

package body Frame is

    procedure Tracer_Segment_Secu(Xf1, Yf1, Xf2, Yf2 : in Float) is
        a, b : Float := 0.0;
        X1, X2, Y1, Y2 : Integer := 0;
        Xp1, Xp2, Yp1, Yp2 : Integer := -1;
    begin
        if (Xf1 >= 1.0) and then (Xf2 >= 1.0) and then (Yf1 >= 1.0) and then (Yf2 >= 1.0) then
            X1 := Natural(Xf1);
            X2 := Natural(Xf2);
            Y1 := Natural(Yf1);
            Y2 := Natural(Yf2);
        end if;
            
        if (X1 <= SCRW) and then (Y1 <= SCRH) and then (X2 <= SCRW) and then (Y2 <= SCRH)  then
            Tracer_Segment(X1,Y1,X2,Y2);
    --    else
    --        a := Float(Y2-Y1)/Float(X2-X1);
    --        b := Float(Y1) - a*Float(X1);

    --        Xp1 := Integer((1.0 - b)/a);
    --        Xp2 := Integer((Float(SCRH) - b)/a);
    --        Yp1 := Integer(a+b);
    --        Yp2 := Integer(a*Float(SCRW) + b);

    --        -- Intersections avec chaque bord de l'écran
    --        if (X1 in 1..SCRW) and (Y1 in 1..SCRH) then
    --            --Xf1 := Float(X1); Yf1 := Float(Y1);

    --            if Xp1 in 1..SCRW then
    --                X2 := Xp1;
    --            else
    --                X2 := Xp2;
    --            end if;
    --                
    --            if Yp1 in 1..SCRH then
    --                Y2 := Yp1;
    --            else
    --                Y2 := Yp2;
    --            end if;
    --        end if;
    --        if (X2 in 1..SCRW) and (Y2 in 1..SCRH) then
    --            --Xf2 := Float(X2); Yf2 := Float(Y2);

    --            if Xp1 in 1..SCRW then
    --                X1 := Xp1;
    --            else
    --                X1 := Xp2;
    --            end if;
    --                
    --            if Yp1 in 1..SCRH then
    --                Y1 := Yp1;
    --            else
    --                Y1 := Yp2;
    --            end if;
    --        end if;

        end if;
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
            
            Tracer_Segment_Secu(P1(1), P1(2), P2(1), P2(2));
            Tracer_Segment_Secu(P1(1), P1(2), P2(1), P2(2));
            Tracer_Segment_Secu(P2(1), P2(2), P3(1), P3(2));
        end loop;
--    exception
--        when CONSTRAINT_ERROR =>
--            null;
    end ;
end Frame;
