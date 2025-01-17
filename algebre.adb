with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;
with Ada.Text_IO;
use Ada.Text_IO;
package body Algebre is

    -- Produit_Matrice (non mis dans l'ADS car utilisé seulement en local)
    -- Recquiet : deux matrices de tailles quelconques
    -- Garantit : la produit de ces deux matrices    
    -- Raise l'exception Tailles_non_compatibles si on essaie de multiplier des matrices qui ne peuvent pas l'être
    -- Il ne semblait pas ici nécessaire d'implémenter un algorithme plus performant que l'algorithme naïf
    -- la fonction étant destinée à des matrices de taille 3 dans ce projet.
    function Produit_Matrice(X : Matrice ; Y : Matrice) return Matrice is 
        Z : Matrice(X'Range(1), Y'Range(2));
        Tailles_non_compatibles: Exception;
    begin
        if X'Length(2) /= Y'Length(1) then
            raise Tailles_non_compatibles;
        end if;

        for i in Z'Range(1) loop
            for j in Z'Range(2) loop
                Z(i,j) := 0.0;
                for k in X'Range(2) loop
                    Z(i,j) := Z(i,j) + X(i,k) * Y(k,j);  	
                end loop;
            end loop;
        end loop;
        return Z;
    end;

    -- Matrice_Rotation (non mis dans l'ADS car utilisé seulement en local)
    -- Recquiert : une lettre x, y ou z pour indiqué l'axe autour duquel se fait la rotation
    --              et un Float pour la valeur de l'angle de la rotation
    -- Garanti : la matrice de la rotation de 'Angle' degrés autour de l'axe 'Axe'
    function Matrice_Rotation(Axe : Character ; Angle : Float) return Matrice is
        Rotation : Matrice (1..3,1..3);
    begin
        if Axe = 'x' then
            Rotation := ((1.0, 0.0, 0.0),(0.0, Cos(Angle), -Sin(Angle)), (0.0, Sin(Angle), Cos(Angle)));
        elsif Axe = 'y' then
            Rotation := ((Cos(Angle), 0.0, Sin(Angle)),(0.0, 1.0, 0.0), (-Sin(Angle), 0.0, Cos(Angle)));
        elsif Axe = 'z' then
            Rotation := ((Cos(Angle), -Sin(Angle), 0.0),(Sin(Angle), Cos(Angle), 0.0), (0.0, 0.0, 1.0));
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
        P := A - C;
        D := T*P;
       -- on ne veut pas afficher les points qui sont ferrière la caméra 
       if D(3) >= 0.0 then
            Resultat(1) := (E(3)/D(3))*D(1)-E(1);
            Resultat(2) := (E(3)/D(3))*D(2)-E(2);
       end if;
        return Resultat;
    end;

end;
