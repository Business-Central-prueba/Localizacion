page 50105 API_proyectos
{
    APIGroup = 'Localizacion';
    APIPublisher = 'KIS';
    APIVersion = 'v2.0';
    Caption = 'apiProyectos';
    DelayedInsert = true;
    EntityName = 'Proyectos';
    EntitySetName = 'Proyectos';
    PageType = API;
    SourceTable = Job;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                // field(creationDate; Rec."Creation Date")
                // {
                //     Caption = 'Creation Date';
                // }
                // field(startingDate; Rec."Starting Date")
                // {
                //     Caption = 'Starting Date';
                // }
                // field(endingDate; Rec."Ending Date")
                // {
                //     Caption = 'Ending Date';
                // }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                // field(personResponsible; Rec."Person Responsible")
                // {
                //     Caption = 'Person Responsible';
                // }
                // field(globalDimension1Code; Rec."Global Dimension 1 Code")
                // {
                //     Caption = 'Global Dimension 1 Code';
                // }
                // field(globalDimension2Code; Rec."Global Dimension 2 Code")
                // {
                //     Caption = 'Global Dimension 2 Code';
                // }
                // field(jobPostingGroup; Rec."Job Posting Group")
                // {
                //     Caption = 'Job Posting Group';
                // }
                // field(blocked; Rec.Blocked)
                // {
                //     Caption = 'Blocked';
                // }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                // field(customerDiscGroup; Rec."Customer Disc. Group")
                // {
                //     Caption = 'Customer Disc. Group';
                // }
                // field(customerPriceGroup; Rec."Customer Price Group")
                // {
                //     Caption = 'Customer Price Group';
                // }
                // field(languageCode; Rec."Language Code")
                // {
                //     Caption = 'Language Code';
                // }
                // field(scheduledResQty; Rec."Scheduled Res. Qty.")
                // {
                //     Caption = 'Scheduled Res. Qty.';
                // }
                // field(scheduledResGrQty; Rec."Scheduled Res. Gr. Qty.")
                // {
                //     Caption = 'Scheduled Res. Gr. Qty.';
                // }
                field(billToName; Rec."Bill-to Name")
                {
                    Caption = 'Bill-to Name';
                }
                field(billToAddress; Rec."Bill-to Address")
                {
                    Caption = 'Bill-to Address';
                }
                // field(billToAddress2; Rec."Bill-to Address 2")
                // {
                //     Caption = 'Bill-to Address 2';
                // }
                field(billToCity; Rec."Bill-to City")
                {
                    Caption = 'Bill-to City';
                }
                // field(billToCounty; Rec."Bill-to County")
                // {
                //     Caption = 'Bill-to County';
                // }
                field(billToPostCode; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(billToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    Caption = 'Bill-to Country/Region Code';
                }
                // field(billToName2; Rec."Bill-to Name 2")
                // {
                //     Caption = 'Bill-to Name 2';
                // }
                field(reserve; Rec.Reserve)
                {
                    Caption = 'Reserve';
                }
                // field(image; Rec.Image)
                // {
                //     Caption = 'Image';
                // }
                // field(wipMethod; Rec."WIP Method")
                // {
                //     Caption = 'WIP Method';
                // // }
                // field(currencyCode; Rec."Currency Code")
                // {
                //     Caption = 'Currency Code';
                // }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                    Caption = 'Bill-to Contact No.';
                }
                field(billToContact; Rec."Bill-to Contact")
                {
                    Caption = 'Bill-to Contact';
                }
                field(totalWIPCostAmount; Rec."Total WIP Cost Amount")
                {
                    Caption = 'Total WIP Cost Amount';
                }
                field(totalWIPCostGLAmount; Rec."Total WIP Cost G/L Amount")
                {
                    Caption = 'Total WIP Cost G/L Amount';
                }
                field(wipEntriesExist; Rec."WIP Entries Exist")
                {
                    Caption = 'WIP Entries Exist';
                }
                field(wipPostingDate; Rec."WIP Posting Date")
                {
                    Caption = 'WIP Posting Date';
                }
                field(wipGLPostingDate; Rec."WIP G/L Posting Date")
                {
                    Caption = 'WIP G/L Posting Date';
                }
                // field(invoiceCurrencyCode; Rec."Invoice Currency Code")
                // {
                //     Caption = 'Invoice Currency Code';
                // }
                field(exchCalculationCost; Rec."Exch. Calculation (Cost)")
                {
                    Caption = 'Exch. Calculation (Cost)';
                }
                field(exchCalculationPrice; Rec."Exch. Calculation (Price)")
                {
                    Caption = 'Exch. Calculation (Price)';
                }
                field(allowScheduleContractLines; Rec."Allow Schedule/Contract Lines")
                {
                    Caption = 'Allow Budget/Billable Lines';
                }
                field(complete; Rec.Complete)
                {
                    Caption = 'Complete';
                }
                field(recogSalesAmount; Rec."Recog. Sales Amount")
                {
                    Caption = 'Recog. Sales Amount';
                }
                field(recogSalesGLAmount; Rec."Recog. Sales G/L Amount")
                {
                    Caption = 'Recog. Sales G/L Amount';
                }
                field(recogCostsAmount; Rec."Recog. Costs Amount")
                {
                    Caption = 'Recog. Costs Amount';
                }
                field(recogCostsGLAmount; Rec."Recog. Costs G/L Amount")
                {
                    Caption = 'Recog. Costs G/L Amount';
                }
                field(totalWIPSalesAmount; Rec."Total WIP Sales Amount")
                {
                    Caption = 'Total WIP Sales Amount';
                }
                field(totalWIPSalesGLAmount; Rec."Total WIP Sales G/L Amount")
                {
                    Caption = 'Total WIP Sales G/L Amount';
                }
                field(wipCompletionCalculated; Rec."WIP Completion Calculated")
                {
                    Caption = 'WIP Completion Calculated';
                }
                field(nextInvoiceDate; Rec."Next Invoice Date")
                {
                    Caption = 'Next Invoice Date';
                }
                field(applyUsageLink; Rec."Apply Usage Link")
                {
                    Caption = 'Apply Usage Link';
                }
                field(wipWarnings; Rec."WIP Warnings")
                {
                    Caption = 'WIP Warnings';
                }
                field(wipPostingMethod; Rec."WIP Posting Method")
                {
                    Caption = 'WIP Posting Method';
                }
                field(appliedCostsGLAmount; Rec."Applied Costs G/L Amount")
                {
                    Caption = 'Applied Costs G/L Amount';
                }
                field(appliedSalesGLAmount; Rec."Applied Sales G/L Amount")
                {
                    Caption = 'Applied Sales G/L Amount';
                }
                field(calcRecogSalesAmount; Rec."Calc. Recog. Sales Amount")
                {
                    Caption = 'Calc. Recog. Sales Amount';
                }
                field(calcRecogCostsAmount; Rec."Calc. Recog. Costs Amount")
                {
                    Caption = 'Calc. Recog. Costs Amount';
                }
                field(calcRecogSalesGLAmount; Rec."Calc. Recog. Sales G/L Amount")
                {
                    Caption = 'Calc. Recog. Sales G/L Amount';
                }
                field(calcRecogCostsGLAmount; Rec."Calc. Recog. Costs G/L Amount")
                {
                    Caption = 'Calc. Recog. Costs G/L Amount';
                }
                field(wipCompletionPosted; Rec."WIP Completion Posted")
                {
                    Caption = 'WIP Completion Posted';
                }
                field(overBudget; Rec."Over Budget")
                {
                    Caption = 'Over Budget';
                }
                // field(projectManager; Rec."Project Manager")
                // {
                //     Caption = 'Project Manager';
                // }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
                // field(sellToCustomerName2; Rec."Sell-to Customer Name 2")
                // {
                //     Caption = 'Sell-to Customer Name 2';
                // }
                field(sellToAddress; Rec."Sell-to Address")
                {
                    Caption = 'Sell-to Address';
                }
                // field(sellToAddress2; Rec."Sell-to Address 2")
                // {
                //     Caption = 'Sell-to Address 2';
                // }
                field(sellToCity; Rec."Sell-to City")
                {
                    Caption = 'Sell-to City';
                }
                field(sellToContact; Rec."Sell-to Contact")
                {
                    Caption = 'Sell-to Contact';
                }
                field(sellToPostCode; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code';
                }
                // field(sellToCounty; Rec."Sell-to County")
                // {
                //     Caption = 'Sell-to County';
                // }
                field(sellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                    Caption = 'Sell-to Country/Region Code';
                }
                // field(sellToPhoneNo; Rec."Sell-to Phone No.")
                // {
                //     Caption = 'Sell-to Phone No.';
                // }
                field(sellToEMail; Rec."Sell-to E-Mail")
                {
                    Caption = 'Email';
                }
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                    Caption = 'Sell-to Contact No.';
                }
                // field(shipToCode; Rec."Ship-to Code")
                // {
                //     Caption = 'Ship-to Code';
                // }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                // field(shipToName2; Rec."Ship-to Name 2")
                // {
                //     Caption = 'Ship-to Name 2';
                // }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                // field(shipToAddress2; Rec."Ship-to Address 2")
                // {
                //     Caption = 'Ship-to Address 2';
                // }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County';
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                // field(paymentMethodCode; Rec."Payment Method Code")
                // {
                //     Caption = 'Payment Method Code';
                // }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                // field(yourReference; Rec."Your Reference")
                // {
                //     Caption = 'Your Reference';
                // }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(costCalculationMethod; Rec."Cost Calculation Method")
                {
                    Caption = 'Cost Calculation Method';
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                    Caption = 'Completely Picked';
                }
                field("EstadoCotizacion"; Rec."Estado Cotización")
                {
                    Caption = 'stado Cotización';
                }

            }
        }
    }
}
