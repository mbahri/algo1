with STL; use STL;

procedure test is
    M : Maillage;
    --Nb : Natural;
begin
    --Nb := Nombre_Facettes("cube.stl");
    --M := new Tableau_Facette(1..Nb);
    M := Chargement_ASCII("saucer_top.stl");
end;
