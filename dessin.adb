with Interfaces.C;

-- les procedures de ce paquetage sont un brin complexes
-- vous ne devriez normalement pas avoir besoin de les modifier
-- vous pouvez le faire, mais a vos risques et perils

package body Dessin is
    package  C  renames Interfaces.C;

    use Uint8_Ptrs;
    use Uint8_PtrOps;
    use Interfaces;
    use type C.int;

    procedure Fixe_Pixel(X : Pixel_X ; Y : Pixel_Y ; Valeur : Uint8) is
        Pointy : Uint8_PtrOps.Pointer;
    begin
        Pointy := Uint8_PtrOps.Pointer(Pixels);
        Pointy := Pointy + C.ptrdiff_t(C.int(X-1 + (Y-1)*Pitch));
        Uint8_Ptrs.Object_Pointer(Pointy).all := Valeur;
    end Fixe_Pixel;

    procedure Trace_Pixel(X : Integer ; Y : Integer) is
        --Modifications apportées :
        --  * Changement du type des paramètres en Integer
        --  * Ajout d'un test d'appartenance des points à la zone affichable
        --  But : Ne pas tracer les morceaux de segments qui sont hors de la zone affichable
        --  Problème : La pénalité de performances est très grande lorsque la caméra est dans l'objet
        --  Une solution basée sur la résolution des collisions entre chaque segment à afficher et le cadre de l'écran semble plus indiquée.
    begin
        if X in 1..SCRW and then Y in 1..SCRH then
            Fixe_Pixel(Pixel_X(X), Pixel_Y(Y), 255);
        end if;
    end;

end;
