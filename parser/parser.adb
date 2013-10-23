with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure parser is
    F : File_Type;
    T : Float;
    C : Character;
    Indice : Natural := 0;
begin
    Open(File => F, Mode => In_File, Name => "cube.stl");
    Skip_Line(F); 
    Get(F, C);

    while not End_of_File(F) loop
        Get(F, C);
        if C = 'v' then
            Indice := (Indice + 1) mod 3; 
            while not (C = ' ') loop
                Get(F,C);
            end loop;
            for I in 1..3 loop
                Get(F, T);
                Put(T);
                case Indice is
                    when 1 => Face.P1(I) := Float'Value(U.To_String(Buffer));
                    --          Indice := 2;
                    when 2 => Face.P2(I) := Float'Value(U.To_String(Buffer));
                    --          Indice := 3;
                    when 0 => Face.P3(I) := Float'Value(U.To_String(Buffer));
                    --          Indice := 1;
                    when others => null;
                end case;
            end loop;
            New_Line;
        end if;
    end loop;
end;
