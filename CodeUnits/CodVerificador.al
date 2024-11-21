codeunit 50100 ValidarDigitoVerificador
{

    procedure VerificarRUT(RUT: Integer)
    var
        rut_cliente: Integer;
        length: Integer;
    begin
        rut_cliente := RUT;
        length := StrLen(Format(rut_cliente));
        if (length < 7) OR (length > 8 ) then begin
            Message('Rut inválido');
            Error('El Rut ingresado no es válido');
        end; 
    end;


    procedure ValidarDigitoVerificador(RUT: Integer; digitoV: Code[1])
    var
        substring: Text[1];
        myTextList: List of [Text];
        value1: Integer;
        value2: Integer;
        value3: Integer;
        value4: Integer;
        value5: Integer;
        value6: Integer;
        value7: Integer;
        value8: Integer;
        result: Integer;
        num: Integer;
        dv: Integer;
        k: Code[1];
        rut_cliente: Integer;
        length: Integer;
    begin

        rut_cliente := RUT;
        length := StrLen(Format(rut_cliente));
        if (length = 8) then begin

            substring := CopyStr(Format(Rut_Cliente), 1, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 2, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 3, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 4, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 5, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 6, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 7, 1);
            myTextList.Add(substring);

            substring := CopyStr(Format(Rut_Cliente), 8, 1);
            myTextList.Add(substring);

            myTextList.Reverse();

            EVALUATE(value1, myTextList.Get(1));
            EVALUATE(value2, myTextList.Get(2));
            EVALUATE(value3, myTextList.Get(3));
            EVALUATE(value4, myTextList.Get(4));
            EVALUATE(value5, myTextList.Get(5));
            EVALUATE(value6, myTextList.Get(6));
            EVALUATE(value7, myTextList.Get(7));
            EVALUATE(value8, myTextList.Get(8));

            result := (value1 * 2) + (value2 * 3) + (value3 * 4) + (value4 * 5) + (value5 * 6) + (value6 * 7) + (value7 * 2) + (value8 * 3);

            num := Round((result / 11), 1, '<');

            result := Abs(result - (num * 11));

            dv := 11 - result;

            if (dv = 11) then
                dv := 0
            else
                if (dv = 10) then
                    k := 'k';

            if (digitoV = Format(dv)) OR (digitoV = k) then
            begin
                //Message('El dígito verificador es correcto')
            end   
            else
                Error('El dígito verificador ingresado es inválido')

        end

        else
            if (length = 7) then begin
                substring := CopyStr(Format(Rut_Cliente), 1, 1);
                myTextList.Add(substring);

                substring := CopyStr(Format(Rut_Cliente), 2, 1);
                myTextList.Add(substring);

                substring := CopyStr(Format(Rut_Cliente), 3, 1);
                myTextList.Add(substring);

                substring := CopyStr(Format(Rut_Cliente), 4, 1);
                myTextList.Add(substring);

                substring := CopyStr(Format(Rut_Cliente), 5, 1);
                myTextList.Add(substring);

                substring := CopyStr(Format(Rut_Cliente), 6, 1);
                myTextList.Add(substring);

                substring := CopyStr(Format(Rut_Cliente), 7, 1);
                myTextList.Add(substring);

                myTextList.Reverse();

                EVALUATE(value1, myTextList.Get(1));
                EVALUATE(value2, myTextList.Get(2));
                EVALUATE(value3, myTextList.Get(3));
                EVALUATE(value4, myTextList.Get(4));
                EVALUATE(value5, myTextList.Get(5));
                EVALUATE(value6, myTextList.Get(6));
                EVALUATE(value7, myTextList.Get(7));

                result := (value1 * 2) + (value2 * 3) + (value3 * 4) + (value4 * 5) + (value5 * 6) + (value6 * 7) + (value7 * 2);

                num := Round((result / 11), 1, '<');

                result := Abs(result - (num * 11));

                dv := 11 - result;

                if (dv = 11) then
                    dv := 0
                else
                    if (dv = 10) then
                        k := 'k';

                if (digitoV = Format(dv)) OR (digitoV = k) then
                begin
                    //Message('El dígito verificador es correcto')
                end
                else
                    Error('El dígito verificador ingresado es inválido');
            end;


    end;
}