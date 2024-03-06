inherited frmCadastroPessoa: TfrmCadastroPessoa
  Caption = 'frmCadastroPessoa'
  TextHeight = 15
  inherited pnlFundo: TPanel
    inherited CardPanel1: TCardPanel
      ActiveCard = viewDados
      inherited viewDados: TCard
        object lblCodigo: TLabel [0]
          Left = 48
          Top = 128
          Width = 39
          Height = 15
          Caption = 'C'#243'digo'
        end
        object lblNome: TLabel [1]
          Left = 48
          Top = 176
          Width = 33
          Height = 15
          Caption = 'Nome'
        end
        object lblDataCadastro: TLabel [2]
          Left = 48
          Top = 224
          Width = 90
          Height = 15
          Caption = 'Data de Cadastro'
        end
        object lblTelefone: TLabel [3]
          Left = 48
          Top = 280
          Width = 44
          Height = 15
          Caption = 'Telefone'
        end
        object lblEndereco: TLabel [4]
          Left = 48
          Top = 336
          Width = 49
          Height = 15
          Caption = 'Endere'#231'o'
        end
        inherited pnlTitulo: TPanel
          inherited lblTitulo: TLabel
            Width = 902
            Height = 56
            Caption = 'Cadastro de Pessoas'
            ExplicitWidth = 221
          end
        end
        object edtCodigo: TEdit
          Left = 48
          Top = 149
          Width = 90
          Height = 23
          Enabled = False
          ReadOnly = True
          TabOrder = 1
        end
        object edtNome: TEdit
          Left = 48
          Top = 197
          Width = 471
          Height = 23
          TabOrder = 2
        end
        object edtDataCadastro: TEdit
          Left = 48
          Top = 245
          Width = 169
          Height = 23
          TabOrder = 3
        end
        object edtTelefone: TEdit
          Left = 48
          Top = 301
          Width = 169
          Height = 23
          TabOrder = 4
        end
        object edtEndereco: TEdit
          Left = 48
          Top = 357
          Width = 785
          Height = 23
          TabOrder = 5
        end
      end
      inherited viewPesquisa: TCard
        inherited pnlPesquisa: TPanel
          inherited btnPesquisa: TSpeedButton
            OnClick = btnPesquisaClick
          end
          inherited lblConsulta: TLabel
            Caption = 'Consulta de Pessoas'
            Color = 15592924
            ExplicitWidth = 185
          end
          inherited edtPesquisa: TEdit
            OnKeyPress = edtPesquisaKeyPress
          end
        end
        inherited dbgrdPesquisa: TDBGrid
          OnCellClick = dbgrdPesquisaCellClick
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'dataCadastro'
              Title.Caption = 'Data de Cadastro'
              Width = 112
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'telefone'
              Title.Caption = 'Telefone'
              Width = 112
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'endereco'
              Title.Caption = 'Endere'#231'o'
              Width = 300
              Visible = True
            end>
        end
      end
    end
  end
end
