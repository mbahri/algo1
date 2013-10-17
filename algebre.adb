with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package body Algebre is

    -- Fonction pour le produit de matrices de taille 3, utilisée dans les fonctions Matrice_Rotations
    -- POSSIBILITE DE FAIRE UNE MULT POUR TOUTE TAILLE
    -- Il ne semblait pas ici nécessaire d'implémenter un algorithme plus performant que l'algorithme naïf, la fonction étant destinée à des matrices de taille 3.
    function Produit_Matrice(X : Matrice ; Y : Matrice) return Matrice is 
        Z : Matrice(1..3, 1..3);
    begin
        for i in 1..3 loop
            for j in 1..3 loop
                Z(i,j) := 0.0;
                for k in 1..3 loop
                    Z(i,j) := Z(i,j) + X(i,k) * Y(k,j);  	
                end loop;
            end loop;
        end loop;

        return Z;
    end;

    -- Possibilité de faire un sous type Axe pour ne pas avoir a passer une caractere à chaque fois
    function Matrice_Rotation(Axe : Character ; Angle : Float) return Matrice is
        Rotation : Matrice (1..3,1..3);
    begin
        if Axe = 'x' then
            Rotation := ((1.0, 0.0, 0.0),(0.0, Cos(Angle, 360.0), -Sin(Angle, 360.0)), (0.0, Sin(Angle, 360.0), Cos(Angle, 360.0)));
        elsif Axe = 'y' then
            Rotation := ((Cos(Angle, 360.0), 0.0, Sin(Angle, 360.0)),(0.0, 1.0, 0.0), (-Sin(Angle, 360.0), 0.0, Cos(Angle, 360.0)));
        elsif Axe = 'z' then
            Rotation := ((Cos(Angle, 360.0), -Sin(Angle, 360.0), 0.0),(Sin(Angle, 360.0), Cos(Angle, 360.0), 0.0), (0.0, 0.0, 1.0));
        end if;
        return(Rotation);
    end;

    --voir http://en.wikipedia.org/wiki/3D_projection#Perspective_projection
    function Matrice_Rotations(Angles : Vecteur) return Matrice is
        Rotation : Matrice(1..3, 1..3);
        Rotx : Matrice(1..3, 1..3);
        Roty : Matrice(1..3, 1..3);
        Rotz : Matrice(1..3, 1..3);
    begin
        Rotx := Matrice_Rotation('x', Angles(1));
        Roty := Matrice_Rotation('y', Angles(2));
        Rotz := Matrice_Rotation('z', Angles(3));

        Rotation := Produit_Matrice(Rotz, Produit_Matrice(Roty, Rotx));
        return Rotation;
    end;

    function Matrice_Rotations_Inverses(Angles : Vecteur) return Matrice is
        Rotation : Matrice(1..3, 1..3);
        Rotx : Matrice(1..3, 1..3);
        Roty : Matrice(1..3, 1..3);
        Rotz : Matrice(1..3, 1..3);
    begin
        Rotx := Matrice_Rotation('x', Angles(1));
        Roty := Matrice_Rotation('y', Angles(2));
        Rotz := Matrice_Rotation('z', Angles(3));

        Rotation := Produit_Matrice(Rotx, Produit_Matrice(Roty, Rotz));

        return Rotation;
    end;

    function "*" (X : Matrice ; Y : Vecteur) return Vecteur is
        Z : Vecteur(X'Range(1));
    begin
        for i in X'Range(2) loop
            Z(i):=0.0;
            for j in Y'Range(1) loop
                Z(i):=Z(i)+X(i,j)*Y(j);
            end loop;
        end loop;
        return Z;
    end;

    function "-" (X : Vecteur; Y : Vecteur) return Vecteur is
        Z : Vecteur(X'Range);
    begin
        for i in X'Range loop
            Z(i) := X(i) - Y(i);
        end loop;

        return Z;
    end;

    function Projection(A, C, E : Vecteur ; T : Matrice) return Vecteur is
        Resultat : Vecteur(1..2);
        D : Vecteur(1..3);
        P : Vecteur(1..3);
    begin
        -- QUE FAIRE SI D(3) < 0 pour ne pas afficher les points ????
        P := A - C;
        D := T*P;
        if D(3) >= 0.0 then
            Resultat(1) := (E(3)/D(3))*D(1)-E(1);
            Resultat(2) := (E(3)/D(3))*D(2)-D(2);
        end if;
        return Resultat;
    end;

end;
