tableextension 50001 VOX_SrvZone extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "VOX_Service Zone Code"; code[10])
        {

            Editable = false;
            Caption = 'Service Zone Code';
            FieldClass = FlowField;
            CalcFormula = Lookup (Customer."Service Zone Code" where ("No." = Field ("Sell-to Customer No.")));

        }
    }

    var
        myInt: Integer;
}