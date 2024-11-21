pageextension 50100 "Job Card Ext" extends "Job Card"
{
    layout
    {
        addlast(General)
        {
            field("Estado Cotización"; Rec."Estado Cotización")
            {
                ApplicationArea = All;
                ToolTip = 'Estado de la cotización para el trabajo';
                Caption = 'Estado Cotización';
            }
        }
    }
}