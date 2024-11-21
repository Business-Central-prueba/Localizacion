
// Verificar bien si el ID no está utilizado por otra entidad

tableextension 50109 "Ext. Cliente Actividad" extends Customer
{
    fields
    {
        field(50119; codigo_Actividad; Code[300])
        {
            Caption = 'Localización Chile. Actividad Economica de cliente';
            DataClassification = ToBeClassified;
            //TableRelation = actividadEconomica;
        }

        field(50113; Facebook; Text[100])
        {
            Caption = 'Facebook';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Bug Facebook';
        }

        field(50114; Instagram; Text[100])
        {
            Caption = 'Localización Chile. Cuenta de Instagram del cliente';
            DataClassification = ToBeClassified;
        }

        field(50115; LinkedIn; Text[100])
        {
            Caption = 'Localización Chile. Cuenta de LinkedIn del cliente';
            DataClassification = ToBeClassified;
        }

        field(50116; FacebookCliente; Text[100])
        {
            Caption = 'Localización Chile. Cuenta de Facebook del cliente';
            DataClassification = ToBeClassified;
        }


        field(50117; Rut_Cliente; Integer)
        {
            Caption = 'Localización Chile. RUT del cliente';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ValidarRUT: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(Rut_Cliente);
            end;
        }

        field(50118; DV; Code[1])
        {
            Caption = 'Localización Chile. Dígito verificador';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ValidarRut: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRut.ValidarDigitoVerificador(Rec.Rut_Cliente, DV);
            end;
        }
        field(51000; RewardPoints; Integer)
        {
            Caption = 'Reward Points';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }
}