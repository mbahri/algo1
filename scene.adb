with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;
with Ada.Text_IO;
use Ada.Text_IO;

package body Scene is

    MAUVAIS_INDEX : exception; 

    R : Float := 50.0; -- coordonnee Z initiale de la camera
    Rho : Float := 0.0; -- rotation autour de X
    Theta : Float := 0.0; -- rotation autour de Y
    Phi : Float := 0.0; -- rotation autour de Z

    E : Vecteur(1..3) := (-400.0, -300.0, 400.0); -- position du spectateur
    T : Matrice(1..3, 1..3); -- matrice de rotation

    M : Maillage;

    procedure Modification_Matrice_Rotation is
    begin
        T := Matrice_Rotations ((1 => -Rho, 2 => -Theta, 3 => -Phi));
    end Modification_Matrice_Rotation;

    function Position_Camera return Vecteur is
        Position : Vecteur(1..3);
        Position_initiale : Vecteur(1..3);
    begin
        Position_initiale := (0.0,0.0,-R);
        Position := T*Position_initiale;
        return Position;
    end;

    procedure Projection_Facette(Index_Facette : Positive ; P1, P2, P3 : out Vecteur) is
    begin
        -- a faire enfin à vérifier en tout cas
        Ajout_Maillage;
        P1 := Projection(M1(Index_Facette)(1));
        P2 := Projection(M1(Index_Facette)(2));
        P3 := Projection(M1(Index_Facette)(3));
    end;

    procedure Ajout_Maillage(M1 : Maillage) is
    begin
        -- a faire, a vérifier
        M:=M1;
    end;

    function Nombre_De_Facettes return Natural is
        N : Natural;
    begin
        -- a faire, enfin à vérifier
        Ajout_Maillage;
        N:=M1'Last;
        return N;
    end;

    procedure Modification_Coordonnee_Camera(Index : Positive ; Increment : Float) is
    begin
        case Index is
            when 1 => R := R + Increment;
            when 2 => Rho := Rho + Increment;
            when 3 => Theta := Theta + Increment;
            when 4 => Phi := Phi + Increment;
            when others => raise MAUVAIS_INDEX; -- Si on demande la modification d'une coordonnée d'indice non dans (1..4), on lève une exception.
        end case;
        Modification_Matrice_Rotation;
    end;

begin
    --initialisation de la matrice de rotation au lancement du programme
    Modification_Matrice_Rotation;
end;
