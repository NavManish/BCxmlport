xmlport 50000 VOX_ExpSalesInvLines
{
    Caption = 'Export Sales Invoice Line';
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    TableSeparator = '<None>';
    RecordSeparator = '<NewLine>';
    TextEncoding = UTF16;
    schema
    {
        textelement(Root)
        {
            tableelement(SalesInvHdr; "Sales Invoice Header")
            {
                RequestFilterFields = "No.";
                XmlName = 'SalesInvoiceHeader';
                tableelement("SalesInvoiceLines"; "Sales Invoice Line")
                {
                    XmlName = 'SalesInvLine';
                    SourceTableView = SORTING ("Document No.", "Line No.") ORDER(Ascending) WHERE (Type = FILTER (Item));
                    LinkTable = SalesInvHdr;
                    LinkFields = "Document No." = FIELD ("No.");
                    LinkTableForceInsert = false;
                    textelement(HardCode1)
                    {
                        width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            HardCode1 := 'ZN';
                        end;
                    }
                    textelement(HardCode2)
                    {
                        width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            HardCode2 := '91';
                        end;
                    }
                    textelement(CustNo)
                    {
                        Width = 17;
                        trigger OnBeforePassVariable();
                        begin
                            CustNo := copystr(SalesInvHdr."Sell-to Customer No.", 1, 17);
                        end;
                    }
                    textelement(CustName)
                    {
                        Width = 50;
                        trigger OnBeforePassVariable();
                        begin
                            CustName := CopyStr(SalesInvHdr."Sell-to Customer Name", 1, 50);
                        End;
                    }
                    textelement(City)
                    {
                        Width = 30;
                        trigger OnBeforePassVariable()
                        begin
                            City := Copystr(SalesInvHdr."Sell-to City", 1, 30);
                        end;
                    }
                    textelement(Province)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable()
                        begin
                            Province := Copystr(SalesInvHdr."Sell-to County", 1, 2);
                        end;
                    }
                    textelement(PostCode)
                    {
                        Width = 20;
                        trigger OnBeforePassVariable();
                        begin
                            PostCode := DelChr(SalesInvHdr."Sell-to Post Code", '=', '''');
                            PostCode := DelChr(PostCode, '=', '-');
                            PostCode := copystr(PostCode, 1, 20);
                        end;
                    }
                    textelement(CountryCode)
                    {
                        Width = 3;
                        trigger OnBeforePassVariable();
                        begin
                            CountryCode := CopyStr(SalesInvHdr."Sell-to Country/Region Code", 1, 3);
                        end;
                    }
                    textelement(blank1)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank1 := '';
                        end;
                    }
                    textelement(blank2)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank2 := '';
                        end;
                    }
                    textelement(blank3)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank3 := '';
                        end;
                    }
                    textelement(blank4)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank4 := '';
                        end;
                    }
                    textelement(blank5)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank5 := '';
                        end;
                    }
                    textelement(blank6)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank6 := '';
                        end;
                    }
                    textelement(blank7)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank7 := '';
                        end;
                    }
                    textelement(blank8)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank8 := '';
                        end;
                    }
                    fieldelement(ItemNo; SalesInvoiceLines."No.")
                    {
                        Width = 18;
                    }
                    textelement(blank9)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank9 := '';
                        end;
                    }
                    textelement(blank10)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank10 := '';
                        end;
                    }
                    fieldelement(Descr; SalesInvoiceLines.Description)
                    {
                        Width = 80;
                    }
                    textelement(blank11)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank11 := '';
                        end;
                    }
                    textelement(DocDate)
                    {
                        Width = 8;
                        trigger OnBeforePassVariable();
                        begin
                            DocDate := FORMAT(SalesInvHdr."Document Date", 0, '<Year4><Month,2><Day,2>');
                        end;
                    }
                    textelement(blank12)
                    {
                        Width = 2;
                        trigger OnBeforePassVariable();
                        begin
                            blank12 := '';
                        end;
                    }
                    fieldelement(InvoicedQty; SalesInvoiceLines.Quantity)
                    {
                        Width = 16;
                    }
                    fieldelement(UOM; SalesInvoiceLines."Unit of Measure Code")
                    {
                        Width = 5;
                    }
                    fieldelement(unitcost; SalesInvoiceLines."Unit Cost (LCY)")
                    {
                        Width = 16;
                    }
                    textelement(ExtPrc)
                    {
                        Width = 16;
                        trigger OnBeforePassVariable();
                        var
                            ExtPrice: Decimal;
                        begin
                            ExtPrice := Round(SalesInvoiceLines.Quantity * SalesInvoiceLines."Unit Cost (LCY)", 0.01, '=');
                            Clear(ExtPrc);
                            ExtPrc := Copystr(Format(ExtPrice), 1, 16);
                        end;
                    }

                    // trigger OnPreXmlItem()
                    // begin
                    //     SalesInvHdr.get(SalesInvoiceLines."Document No.");
                    // end;
                }
                trigger OnPreXmlItem()
                begin
                    if PostDate <> 0D then
                        SalesInvHdr.SetRange(SalesInvHdr."Posting Date", PostDate);
                    if srvZonecode <> '' then
                        SalesInvHdr.SetRange(SalesInvHdr."VOX_Service Zone Code", srvZonecode);
                end;
            }

        }

    }

    procedure InputValue(PostDateParam: Date; SrvZoneParam: code[10])
    begin
        PostDate := PostDateParam;
        srvZonecode := SrvZoneParam;
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        srvZonecode: code[10];
        PostDate: Date;

}
