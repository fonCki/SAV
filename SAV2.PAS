PROGRAM SAV;
USES CRT;
CONST MaxCiudades = 10;
CONST NoHayRuta = -1;
      VAcio = -2;

TYPE Mat = Array [1..MaxCiudades, 1..MaxCiudades] of integer;
     Arr = Array [1..MaxCiudades] of string;
     ArrEnt = Array [1..MaxCiudades] of integer;


Function NombreCiudad(ArC:arr; Indice:integer): string;
Var I:integer;

Begin
     I:=1;
     While I <> Indice do
          I:=I+1;
     NombreCiudad:=ArC[I];
end;



Function Indice(ArC:arr; Ciudad:string):integer;
Var I:integer;

Begin
     I:=1;
     While ArC[I] <> Ciudad do
           I:= I+1;
     Indice:= I;
end;


Function HayRuta(valor:integer):boolean;
Begin
     HayRuta:= (Valor <> NoHayRuta);
End;

{************************}
Function ExisteCiudad(ArC:Arr; Ciudad:string; MaxCE:integer):boolean;
Var  Encontro:Boolean;
     C:integer;
Begin
   Encontro:=false;
   C:=1;
   WHILE not Encontro and (C <= MaxCE) do
     Begin
       IF Ciudad = ArC[C] THEN
           Encontro:=true
       ELSE
        C:=C+1;
     end;
   ExisteCiudad:= Encontro;
end;


Function IngresaCiudad(ArC:arr;MaxCE:integer): string;
Var Ciudad:string;
    Salir:boolean;


Begin
     REPEAT
     Salir:=false;
     Writeln;
     Writeln('Ingrese la ciudad:');
     Readln(Ciudad);
     If ExisteCiudad(ArC,Ciudad,MaxCE) then
        Begin
             IngresaCiudad:= Ciudad;
             Salir:=true;
        end
     Else
         Begin
              Writeln('La ciudad no existe');
              Writeln;
              Readkey;
         end;
     Until Salir
end;

Procedure Camino_Entre_Dos_Ciudades(ArC:arr; MaxCE:integer; MatDD:mat; MatD:mat; MatPD:mat);
Var Origen,Destino:string;
    IndOrigen,IndDestino,IndCiudad:integer;
Begin
     Writeln('Ciudad de Origen');
     Origen:=IngresaCiudad(ArC,MaxCE);
     Writeln;
     Writeln('Ciudad de Destino');
     Destino:=IngresaCiudad(ArC,MaxCE);
     Writeln('El camino entre ',Origen,' y ',Destino,' es:');
     IndOrigen:=Indice(ArC,Origen);
     IndDestino:=Indice(ArC,Destino);
     indciudad:=indorigen;
     while matpd[indciudad,inddestino] <> inddestino do
         begin
           write(nombreciudad(arc,matpd[indciudad,inddestino]),'  ');
           writeln(matDD[indciudad,matpd[indciudad,inddestino]]);
           indciudad:=matpd[indciudad,inddestino]
         end;
           write(nombreciudad(arc,inddestino),'  ');
           writeln(matDD[indciudad,inddestino]);
      writeln(matd[indorigen,inddestino]);
    readln;
end;


procedure Ordenar(var arreglo:arr; final:integer);
var aux:string;
  i,j:integer;
begin
    FOR i:= 1 to final - 1 DO
          FOR J:= 1 to final - 1 DO
              IF Arreglo[j] > Arreglo[j+1] THEN
                 Begin
                      Aux:= Arreglo[j];
                      Arreglo[j]:=Arreglo[j+1];
                      Arreglo[j+1]:=Aux;
                 End;
end;

Procedure Listado_De_Ciudades(ArC:arr; ArCO:arrent; MaxCE:integer; MatDD:mat);
Var I,E,IndiceCiudad:integer;
    Aux,Ciudad:string;
    ArAux:arr;
Begin
      Ciudad:=IngresaCiudad(ArC,MaxCE);
      IndiceCiudad:=Indice(ArC,Ciudad);
      e:=0;
      For I:=1 to MaxCE do
          Begin
               If MatDD[IndiceCiudad,i] <> NoHayRuta then
                 begin
                   e:=e+1;
                   ArAux[e]:= NombreCiudad(ArC, i);
                 end;
            end;
      ordenar(araux,e);
      Writeln;
      Writeln('Las ciudades contiguas a ',Ciudad,' son: ');
      For i:=1 to e do
         Writeln(ArAux[i],' ',MatDD[IndiceCiudad,Indice(ArC,ArAux[i])],' Km.');
    readln;

end;


{************************}


{************************}
Procedure Inicializa_Distancias_y_Primer_Destino(MaxCiudadesExistentes: integer; MatDistanciasDirectas:Mat;var
   MatDistancias: Mat; var MatPrimerDestino: Mat);
Var Origen, Destino: integer;
Begin
     For Origen:= 1 to MaxCiudadesExistentes do
         For Destino:= 1 to MaxCiudadesExistentes do
             If HayRuta(MatDistanciasDirectas[Origen,Destino]) then
                Begin
                     MatDistancias[Origen,Destino]:= MatDistanciasDirectas[Origen,Destino];
                     MatPrimerDestino[Origen,Destino]:= Destino;
                end
             Else
                Begin
                     MatDistancias[Origen,Destino]:= NoHayRuta;
                     MatPrimerDestino[Origen,Destino]:= Destino;
                end;
End;

{************************}
Procedure Actualiza_Distancias_y_Primer_Destino(MaxCiudadesExistentes:Integer;
MatDistanciasDirectas: Mat; Var MatDistancias: Mat; Var MatPrimerDestino: Mat);
Var SeCambioDistancia: boolean;
Var Origen, Destino,Intermedio: integer;
Begin
     SeCambioDistancia:= true;
     While SeCambioDistancia do
       Begin
         SeCambioDistancia:= false;
         For Origen:= 1 to MaxCiudadesExistentes do
            For Destino:= 1 to MaxCiudadesExistentes do
               For Intermedio:= 1 to MaxCiudadesExistentes do
                  If (Origen <> Destino) and
                     HayRuta (MatDistancias[Origen,Intermedio]) and
                     HayRuta (MatDistancias[Intermedio,Destino]) and
                     (not HayRuta (MatDistancias[Origen,Destino]) or
                     (MatDistancias[Origen,Destino] > MatDistancias[Origen,Intermedio] +
                      MatDistancias[Intermedio,Destino])) then
                      Begin
                        MatDistancias[Origen,Destino]:=MatDistancias[Origen,Intermedio] +
                        MatDistancias[Intermedio,Destino];
                        MatPrimerDestino[Origen,Destino]:= MatPrimerDestino[Origen,Intermedio];
                        SeCambioDistancia:=true;
                       end;

      End;
End;

{************************}
Procedure Genera_Distancias_Y_PrimerDestino(MaxCE:integer; MatDD:mat;
          var MatD:mat; var MatPD:mat);

Begin
 Inicializa_Distancias_Y_Primer_Destino(MaxCE, MatDD, MatD, MatPD);
 Actualiza_Distancias_Y_Primer_Destino(MaxCE, MatDD, MatD, MatPD);
end;

{************************}

{************************}
Procedure OrdenarCiudades(MaxCE:integer; ArC:arr; var ArCO:arrent);
Var I,J:integer;
    Aux:string;
    ArAux:arr;
Begin
     ArAux:=ArC;
     ordenar(araux,maxce);
     FOR I:=1 to MaxCE DO
        ArCO[I]:= Indice(ArC, ArAux[I]);
end;

{************************}
Procedure Generar_Datos_Adicionales(ArC:arr; MatDD:mat; MaxCE:integer; var ArCO:arrent; var MatD:mat; var MatPD:mat);
Begin
     OrdenarCiudades(MaxCE, ArC, ArCO);
     Genera_Distancias_Y_PrimerDestino(MaxCE, MatDD, MatD, MatPD);
end;

{************************}
Procedure CargarDistDirectas (var ArC:arr; var MatDD:mat;var MaxCE:integer);
Var Distancia,I,J:integer;
    SN:char;

Begin
       Clrscr;
       FOR I:= 1 to MaxCE  do
         FOR J:= I to MaxCE do
           IF I = J THEN
              MatDD[I,J]:= NoHayRuta
             ELSE
              if MatDD[I,J] = vacio then
               Begin
                 Writeln;
                 Writeln('Ingrese la distancia directa de ',ArC[I],' a ',ArC[J]);
                 Writeln('Recuerde que si la distancia no es directa el valor debe ser -1');
                 Readln(MatDD[I,J]);
                 MatDD[J,I]:= MatDD[I,J];
                 Writeln;
               end;
end;



{************************}
Procedure CargarCiudades (var ArC:arr; var MaxCE:integer);
Var Ciudad:string;
    No:char;
    Seguir,girar:boolean;
    I:integer;

Begin
    Seguir:= false;
    Girar:= false;

    REPEAT
     REPEAT
      Writeln;
      Writeln ('Ingrese nombre de la ciudad');
      Readln (Ciudad);
      IF ciudad <> '' then girar:=true;
     Until girar;
     IF ExisteCiudad(ArC,Ciudad,MaxCE) THEN
           Writeln ('La ciudad ya existe')
          ELSE
              IF MaxCE = MaxCiudades THEN
                  Begin
                     Writeln('No se pueden ingresar mas ciudades');
                     Seguir:= true;
                  end
              ELSE
                  Begin
                    MaxCE:= MaxCE + 1;
                    ArC[MaxCE]:= Ciudad;
                  end;
    IF not seguir THEN
      Begin
       Writeln ('Desea cargar otra ciudad S/N:');
       No:=Readkey;
      end;
     UNTIL (No ='n') or seguir;
end;

{************************}
Procedure CargarCiudades_Y_DistDirectas(var ArC:arr; var MatDD:mat; var MaxCE:integer);
Begin
     CargarCiudades(ArC,MaxCE);
     CargarDistDirectas(ArC,MatDD,MaxCE);
end;

{************************}
Procedure InicializarEstructuras(var arc:arr; var MatDD:mat);
Var i,j:integer;
Begin
      FOR I:=1 to MaxCiudades do
         ArC[I]:='';

      FOR I:=1 to MaxCiudades do
        FOR j:=1 to MaxCiudades do
          MatDD[i,j]:= vacio;
end;

procedure Opciones(var opcion:integer);
Var Salir:boolean;
Begin
    REPEAT
          Salir :=false;
          Clrscr;
          Gotoxy(23,2);
          Writeln('INGRESE LA OPCION CORRESPONDIENTE');
          Writeln;
          Writeln('1 - CARGA DE CIUDADES Y DISTANCIAS DIRECTAS');
          Writeln('2 - LISTADO DE CIUDADES CONTIGUAS');
          Writeln('3 - DISTANCIA Y CAMINO ENTRE 2 CIUDADES');
          Writeln('4 - RECORRIDO ENTRE CIUDADES');
          writeln('5 - SALIR');
          Writeln;
          Write('Opcion: ');
          Readln(Opcion);
          Writeln;
    CASE Opcion of
        1..5 : Salir:=true
    ELSE
        Writeln('Escogio mal la opcion'); Readkey;
    END;
    UNTIL salir;
End;
{************************}
VAR ArCiudades:Arr;
    MatDistanciasDirectas,MatDistancias,MatPrimerDestino:Mat;
    MaxCiudadesExistentes,opcion:Integer;
    ArCiudadesOrdenadas:ArrEnt;


BEGIN
     MaxCiudadesExistentes:=0;
     InicializarEstructuras(arciudades,MatDistanciasDirectas);
     repeat
       opciones(opcion);
       case opcion of
       1 : Begin
            CargarCiudades_Y_DistDirectas(ArCiudades,MatDistanciasDirectas,MaxCiudadesExistentes);
            Generar_Datos_Adicionales(ArCiudades,MatDistanciasDirectas,MaxCiudadesExistentes,
            ArCiudadesOrdenadas, MatDistancias, MatPrimerDestino);
           end;
       2 : Listado_De_Ciudades(ArCiudades,ArCiudadesOrdenadas,MaxCiudadesExistentes,MatDistanciasDirectas);
       3 : Camino_Entre_Dos_Ciudades(ArCiudades,MaxCiudadesExistentes,MatDistanciasDirectas,MatDistancias,MatPrimerDestino);
       END;
    Until Opcion = 5;
END.
