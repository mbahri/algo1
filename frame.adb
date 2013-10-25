with Ada.Text_IO; use Ada.Text_IO;
with Dessin; use Dessin;
with Ligne; use Ligne;
with STL ; use STL;
with Algebre ; use Algebre;

with Scene; use Scene;

package body Frame is

    procedure Tracer_Segment_Secu(Xf1, Yf1, Xf2, Yf2 : in Float) is
--        a, b, c : Float := 0.0;
        X1, X2, Y1, Y2 : Integer := 0;
--        Xp1, Xp2, Yp1, Yp2 : Integer := -1;
    begin
--        if (Xf1 >= 1.0) and then (Xf2 >= 1.0) and then (Yf1 >= 1.0) and then (Yf2 >= 1.0) then
            X1 := Integer(Xf1);
            X2 := Integer(Xf2);
            Y1 := Integer(Yf1);
            Y2 := Integer(Yf2);
--        end if;
            
--        if (X1 <= SCRW) and then (Y1 <= SCRH) and then (X2 <= SCRW) and then (Y2 <= SCRH)  then
            Tracer_Segment(X1,Y1,X2,Y2);    
--        elsif X1 /= X2 and then Y1 /= Y2 then
--            a := Float(Y2 - Y1);
--            b := Float(X1 - X2);
--            c := -(b*Float(Y1) + a*Float(X1));
--
--            if X1 < 1 then
--           --     Put_Line("Enfin ! X1");
--                X1 := 1;
--                Y1 := Integer(-(c + a*1.0)/b);
--            elsif X1 > SCRW then
--                X1 := SCRW;
--                Y1 := Integer(-(c + a*Float(SCRW))/b);
--            end if;
--
--            if X2 < 1 then
--            --    Put_Line("Enfin ! X2");
--                X2 := 1;
--                Y2 := Integer(-(c + a*1.0)/b);
--            elsif X2 > SCRW then
--                X2 := SCRW;
--                Y2 := Integer(-(c + a*Float(SCRW))/b);
--            end if;
--
--            if Y1 < 1 then
--            --    Put_Line("Enfin ! Y1");
--                Y1 := 1;
--                X1 := Integer(-(c+b*1.0)/a);
--            elsif Y1 > SCRH then
--                Y1 := SCRH;
--                X1 := Integer(-(c+b*Float(SCRH))/a);
--            end if;
--
--            if Y2 < 1 then
--            --    Put_Line("Enfin ! Y2");
--                Y2 := 1;
--                X2 := Integer(-(c+b*1.0)/a);
--            elsif Y2 > SCRH then
--                Y2 := SCRH;
--                X2 := Integer(-(c+b*Float(SCRH))/a);
--            end if;
--            if X1 in 1..SCRW and then X2 in 1..SCRW and then Y1 in 1..SCRH and then Y2 in 1..SCRH then
--                Tracer_Segment(X1,Y1,X2,Y2);
--            end if;
       -- else
       --     if X1 = X2 then
       --         if X1 > SCRW then
       --             X1 := SCRW;
       --             Y1 := Integer(-(c + a*Float(SCRW))/b);
       --             X2 := SCRW;
       --             Y2 := Integer(-(c + a*Float(SCRW))/b);
       --         elsif X1 <= 1 then
       --             X1 := 1;
       --             Y1 := Integer(-(c + a*1.0)/b);
       --             X2 := 1;
       --             Y2 := Integer(-(c + a*1.0)/b);
       --         end if;
       --     end if;

       --     if Y1 = Y2 then
       --         if Y1 > SCRH then
       --             Y1 := SCRH;
       --             X1 := Integer(-(c+b*Float(SCRH))/a);
       --             Y2 := SCRH;
       --             X2 := Integer(-(c+b*Float(SCRH))/a);
       --         elsif Y1 <= 1 then
       --             Y1 := 1;
       --             X1 := Integer(-(c+b*1.0)/a);
       --             Y2 := 1;
       --             X2 := Integer(-(c+b*1.0)/a);
       --         end if;
       --     end if;
       --     Tracer_Segment(X1,Y1,X2,Y2);    
--        end if;
    --exception
        --when CONSTRAINT_ERROR => null;
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
        -- Tracer_Segment_Secu(1.0,1.0,Float(SCRW),Float(SCRH));
        Nb_Facette:=Nombre_De_Facettes;
        for i in 1..Nb_Facette loop
            Projection_Facette(i, P1, P2, P3);
            
            Tracer_Segment_Secu(P1(1), P1(2), P2(1), P2(2));
            Tracer_Segment_Secu(P1(1), P1(2), P2(1), P2(2));
            Tracer_Segment_Secu(P2(1), P2(2), P3(1), P3(2));
        end loop;
    end ;
end Frame;
