with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package body Algebre is
	
	-- Fonction pour le produit de matrices de taille 3, utilisée dans les fonctions Matrice_Rotations
    -- POSSIBILITE DE FAIRE UNE MULT POUR TOUTE TAILLE
    -- Il ne semblait pas ici nécessaire d'implémenter un algorithme plus performant que l'algorithme naïf, la fonction étant destinée à des matrices de taille 3.
	function Produit_Matrice3(X : Matrice ; Y : Matrice) return Matrice is 
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

	--voir http://en.wikipedia.org/wiki/3D_projection#Perspective_projection
	function Matrice_Rotations(Angles : Vecteur) return Matrice is
		Rotation : Matrice(1..3, 1..3);
	    Rotx : Matrice(1..3, 1..3);
	    Roty : Matrice(1..3, 1..3);
	    Rotz : Matrice(1..3, 1..3);
    begin
        Rotx := ((1.0, 0.0, 0.0),(0.0, cos(Angles(1)), -sin(Angles(1))), (0.0, sin(Angles(1)), cos(Angles(1))));
        Roty := ((cos(Angles(2)), 0.0, sin(Angles(2))),(0.0, 1.0, 0.0), (-sin(Angles(2)), 0.0, cos(Angles(2))));
        Rotz := ((cos(Angles(3)), -sin(Angles(3)), 0.0),(sin(Angles(3)), cos(Angles(3)), 0.0), (0.0, 0.0, 1.0));

        Rotation := Produit_Matrice3(Rotz, Produit_Matrice3(Roty, Rotx));
		return Rotation;
	end;

	function Matrice_Rotations_Inverses(Angles : Vecteur) return Matrice is
		Rotation : Matrice(1..3, 1..3);
	begin
		-- a faire
		return Rotation;
	end;

	function "*" (X : Matrice ; Y : Vecteur) return Vecteur is
		Z : Vecteur(X'Range(1));
	begin
		-- a faire
        for i in 1..X'Range(1) loop
            for j in 1..X'Range(2) loop
                Z(i )=X(i,j)*Y(j)
		return Z;
	end;


    function Projection(A, C, E : Vecteur ; T : Matrice) return Vecteur is
		Resultat : Vecteur(1..2);
	begin
		-- a faire
		return Resultat;
	end;

end;
