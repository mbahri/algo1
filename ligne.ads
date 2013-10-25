package Ligne is
    -- Trace un segment de droite entre (Xa,Ya) et (Xb,Yb)
    -- requiert des coordonnees valides de pixels
    procedure Tracer_Segment(Xa, Ya, Xb, Yb : Integer);     -- Type changé en Integer pour gérer les dépassements d'écran
end;
