tableextension 50104 "Ext. Cuentas Asignacion Distr." extends "Alloc. Account Distribution"
{
    fields
    {
        field(50100; esBoletaHonorario; Boolean)
        {
            Caption = 'Cta. Retención';
            DataClassification = ToBeClassified;
            Description = 'Indica si la cuenta es retención.';
        }
    }

    trigger OnModify()
    var
        OtherRecords: Record "Alloc. Account Distribution";
    begin
        if esBoletaHonorario then begin
            // Buscar y desmarcar todos los demás registros
            OtherRecords.SetRange("Allocation Account No.", "Allocation Account No.");
            if OtherRecords.FindSet() then
                Message('Solo se puede seleccionar un registro como "Cta. Retención". Otros registros serán desmarcados automáticamente.');
            repeat
                if OtherRecords."SystemId" <> Rec."SystemId" then begin
                    OtherRecords.esBoletaHonorario := false;
                    OtherRecords.Modify();
                end;
            until OtherRecords.Next() = 0;
        end;
    end;
}
