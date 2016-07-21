program FarmacyTest;

uses
  Forms,
  DUnitTestRunner,
  SysUtils,
  dbCreateStructureTest in '..\SOURCE\STRUCTURE\dbCreateStructureTest.pas',
  dbMetadataTest in '..\SOURCE\METADATA\dbMetadataTest.pas',
  zLibUtil in '..\SOURCE\zLibUtil.pas',
  CommonFunctionTest in '..\SOURCE\Function\CommonFunctionTest.pas',
  dbFarmacyProcedureTest in '..\SOURCE\dbFarmacyProcedureTest.pas',
  UtilConst in '..\..\SOURCE\UtilConst.pas',
  ProcessTest in '..\SOURCE\Process\ProcessTest.pas',
  dbEnumTest in '..\SOURCE\dbEnumTest.pas',
  dbCreateViewTest in '..\SOURCE\View\dbCreateViewTest.pas',
  DefaultsTest in '..\SOURCE\Defaults\DefaultsTest.pas',
  LoadFarmacyFormTest in '..\SOURCE\LoadFarmacyFormTest.pas',
  PriceListGoodsItem in '..\..\Forms\Guides\PriceListGoodsItem.pas' {PriceListGoodsItemForm},
  CommonData in '..\..\SOURCE\CommonData.pas',
  Authentication in '..\..\SOURCE\Authentication.pas',
  FormStorage in '..\..\SOURCE\FormStorage.pas',
  ParentForm in '..\..\SOURCE\ParentForm.pas' {ParentForm},
  Storage in '..\..\SOURCE\Storage.pas',
  UtilConvert in '..\..\SOURCE\UtilConvert.pas',
  dsdAction in '..\..\SOURCE\COMPONENT\dsdAction.pas',
  dsdAddOn in '..\..\SOURCE\COMPONENT\dsdAddOn.pas',
  dsdDB in '..\..\SOURCE\COMPONENT\dsdDB.pas',
  dsdGuides in '..\..\SOURCE\COMPONENT\dsdGuides.pas',
  DataModul in '..\..\SOURCE\DataModul.pas' {dmMain: TDataModule},
  GoodsPartnerCodeMaster in '..\..\FormsFarmacy\Guides\GoodsPartnerCodeMaster.pas' {GoodsPartnerCodeMasterForm},
  GoodsMainEdit in '..\..\FormsFarmacy\Guides\GoodsMainEdit.pas' {GoodsMainEditForm},
  dbTest in '..\SOURCE\dbTest.pas',
  ChoicePeriod in '..\..\SOURCE\COMPONENT\ChoicePeriod.pas' {PeriodChoiceForm},
  Defaults in '..\..\SOURCE\COMPONENT\Defaults.pas',
  UnilWin in '..\..\SOURCE\UnilWin.pas',
  MessagesUnit in '..\..\SOURCE\MessagesUnit.pas' {MessagesForm},
  SimpleGauge in '..\..\SOURCE\SimpleGauge.pas' {SimpleGaugeForm},
  ClientBankLoad in '..\..\SOURCE\COMPONENT\ClientBankLoad.pas',
  Document in '..\..\SOURCE\COMPONENT\Document.pas',
  ExternalLoad in '..\..\SOURCE\COMPONENT\ExternalLoad.pas',
  Log in '..\..\SOURCE\Log.pas',
  ExternalData in '..\..\SOURCE\COMPONENT\ExternalData.pas',
  ExternalSave in '..\..\SOURCE\COMPONENT\ExternalSave.pas',
  VKDBFDataSet in '..\..\SOURCE\DBF\VKDBFDataSet.pas',
  VKDBFPrx in '..\..\SOURCE\DBF\VKDBFPrx.pas',
  VKDBFUtil in '..\..\SOURCE\DBF\VKDBFUtil.pas',
  VKDBFMemMgr in '..\..\SOURCE\DBF\VKDBFMemMgr.pas',
  VKDBFCrypt in '..\..\SOURCE\DBF\VKDBFCrypt.pas',
  VKDBFGostCrypt in '..\..\SOURCE\DBF\VKDBFGostCrypt.pas',
  VKDBFCDX in '..\..\SOURCE\DBF\VKDBFCDX.pas',
  VKDBFIndex in '..\..\SOURCE\DBF\VKDBFIndex.pas',
  VKDBFSorters in '..\..\SOURCE\DBF\VKDBFSorters.pas',
  VKDBFCollate in '..\..\SOURCE\DBF\VKDBFCollate.pas',
  VKDBFParser in '..\..\SOURCE\DBF\VKDBFParser.pas',
  VKDBFNTX in '..\..\SOURCE\DBF\VKDBFNTX.pas',
  VKDBFSortedList in '..\..\SOURCE\DBF\VKDBFSortedList.pas',
  ObjectTest in '..\SOURCE\Objects\ObjectTest.pas',
  cxGridAddOn in '..\..\SOURCE\DevAddOn\cxGridAddOn.pas',
  MeDOC in '..\..\SOURCE\MeDOC\MeDOC.pas',
  MeDocXML in '..\..\SOURCE\MeDOC\MeDocXML.pas',
  Measure in '..\..\Forms\Measure.pas' {MeasureForm: TParentForm},
  MeasureEdit in '..\..\Forms\MeasureEdit.pas' {MeasureEditForm: TParentForm},
  Box in '..\..\Forms\Box.pas' {BoxForm: TParentForm},
  BoxEdit in '..\..\Forms\BoxEdit.pas' {BoxEditForm: TParentForm},
  ImportExportLinkType in '..\..\Forms\Kind\ImportExportLinkType.pas' {ImportExportLinkTypeForm: TParentForm},
  UnitEdit in '..\..\FormsFarmacy\Guides\UnitEdit.pas' {UnitEditForm: TParentForm},
  AncestorBase in '..\..\Forms\Ancestor\AncestorBase.pas' {AncestorBaseForm: TParentForm},
  AncestorData in '..\..\Forms\Ancestor\AncestorData.pas' {AncestorDataForm: TParentForm},
  AncestorDBGrid in '..\..\Forms\Ancestor\AncestorDBGrid.pas' {AncestorDBGridForm: TParentForm},
  AncestorDialog in '..\..\Forms\Ancestor\AncestorDialog.pas' {AncestorDialogForm: TParentForm},
  AncestorDocument in '..\..\Forms\Ancestor\AncestorDocument.pas' {AncestorDocumentForm: TParentForm},
  AncestorDocumentMC in '..\..\Forms\Ancestor\AncestorDocumentMC.pas' {AncestorDocumentMCForm: TParentForm},
  AncestorEditDialog in '..\..\Forms\Ancestor\AncestorEditDialog.pas' {AncestorEditDialogForm: TParentForm},
  AncestorEnum in '..\..\Forms\Ancestor\AncestorEnum.pas' {AncestorEnumForm: TParentForm},
  AncestorGuides in '..\..\Forms\Ancestor\AncestorGuides.pas' {AncestorGuidesForm: TParentForm},
  AncestorJournal in '..\..\Forms\Ancestor\AncestorJournal.pas' {AncestorJournalForm: TParentForm},
  AboutBoxUnit in '..\..\SOURCE\AboutBoxUnit.pas' {AboutBox},
  dbLoadTest in '..\SOURCE\Load\dbLoadTest.pas',
  Country in '..\..\Forms\Guides\Country.pas' {CountryForm: TParentForm},
  CountryEdit in '..\..\Forms\Guides\CountryEdit.pas' {CountryEditForm: TParentForm},
  MovementLoad in '..\..\FormsFarmacy\Load\MovementLoad.pas' {MovementLoadForm: TParentForm},
  UpdaterTest in '..\SOURCE\Component\UpdaterTest.pas',
  dbObjectTest in '..\SOURCE\dbObjectTest.pas',
  Retail in '..\..\Forms\Guides\Retail.pas' {RetailForm: TParentForm},
  RetailEdit in '..\..\Forms\Guides\RetailEdit.pas' {RetailEditForm: TParentForm},
  Juridical in '..\..\FormsFarmacy\Guides\Juridical.pas' {JuridicalForm: TParentForm},
  JuridicalEdit in '..\..\FormsFarmacy\Guides\JuridicalEdit.pas' {JuridicalEditForm: TParentForm},
  MainForm in '..\..\FormsFarmacy\MainForm.pas' {MainForm},
  IncomeJournal in '..\..\FormsFarmacy\Document\IncomeJournal.pas' {IncomeJournalForm: TParentForm},
  PriceList in '..\..\FormsFarmacy\Document\PriceList.pas' {PriceListForm: TParentForm},
  PriceListJournal in '..\..\FormsFarmacy\Document\PriceListJournal.pas' {PriceListJournalForm: TParentForm},
  OrderExternal in '..\..\FormsFarmacy\Document\OrderExternal.pas' {OrderExternalForm: TParentForm},
  OrderExternalJournal in '..\..\FormsFarmacy\Document\OrderExternalJournal.pas' {OrderExternalJournalForm: TParentForm},
  OrderInternalLite in '..\..\FormsFarmacy\Document\OrderInternalLite.pas' {OrderInternalLiteForm: TParentForm},
  OrderInternalJournal in '..\..\FormsFarmacy\Document\OrderInternalJournal.pas' {OrderInternalJournalForm: TParentForm},
  User in '..\..\Forms\User.pas' {UserForm: TParentForm},
  UserEdit in '..\..\Forms\UserEdit.pas' {UserEditForm: TParentForm},
  Role in '..\..\Forms\Role.pas' {RoleForm: TParentForm},
  RoleEdit in '..\..\Forms\RoleEdit.pas' {RoleEditForm: TParentForm},
  RoleTest in '..\SOURCE\Objects\All\RoleTest.pas',
  ImportType in '..\..\Forms\Import\ImportType.pas' {ImportTypeForm: TParentForm},
  JuridicalTest in '..\SOURCE\Objects\All\Farmacy\JuridicalTest.pas',
  CommonObjectHistoryProcedureTest in '..\SOURCE\ObjectHistory\CommonObjectHistoryProcedureTest.pas',
  MovementItemsLoad in '..\..\FormsFarmacy\Load\MovementItemsLoad.pas' {MovementItemsLoadForm: TParentForm},
  ImportGroup in '..\..\Forms\Import\ImportGroup.pas' {ImportGroupForm: TParentForm},
  FileTypeKind in '..\..\Forms\Kind\FileTypeKind.pas' {FileTypeKindForm: TParentForm},
  PriceListItemsLoad in '..\..\FormsFarmacy\Load\PriceListItemsLoad.pas' {PriceListItemsLoadForm: TParentForm},
  PriceListLoad in '..\..\FormsFarmacy\Load\PriceListLoad.pas' {PriceListLoadForm: TParentForm},
  AdditionalGoods in '..\..\FormsFarmacy\Guides\AdditionalGoods.pas' {AdditionalGoodsForm: TParentForm},
  LinkGoodsTest in '..\SOURCE\Objects\All\LinkGoodsTest.pas',
  GoodsTest in '..\SOURCE\Objects\All\Farmacy\GoodsTest.pas',
  GoodsGroupTest in '..\SOURCE\Objects\All\Farmacy\GoodsGroupTest.pas',
  ImportTypeTest in '..\SOURCE\Objects\All\ImportTypeTest.pas',
  ImportTypeItemsTest in '..\SOURCE\Objects\All\ImportTypeItemsTest.pas',
  MeasureTest in '..\SOURCE\Objects\All\MeasureTest.pas',
  PaidKindTest in '..\SOURCE\Objects\All\PaidKindTest.pas',
  PriceListTest in '..\SOURCE\Objects\All\PriceListTest.pas',
  RetailTest in '..\SOURCE\Objects\All\RetailTest.pas',
  UserTest in '..\SOURCE\Objects\All\UserTest.pas',
  ParentFormTest in '..\SOURCE\Form\ParentFormTest.pas' {TestForm: TParentForm},
  GoodsMainLite in '..\..\FormsFarmacy\Guides\GoodsMainLite.pas' {GoodsMainLiteForm: TParentForm},
  DefaultsKey in '..\..\Forms\System\DefaultsKey.pas' {DefaultsKeyForm: TParentForm},
  Objects in '..\..\Forms\System\Objects.pas' {ObjectForm: TParentForm},
  ImportExportLink in '..\..\Forms\System\ImportExportLink.pas' {ImportExportLinkForm: TParentForm},
  ObjectDesc in '..\..\Forms\System\ObjectDesc.pas' {ObjectDescForm: TParentForm},
  FormsUnit in '..\..\Forms\System\FormsUnit.pas' {FormsForm: TParentForm},
  UnionDesc in '..\..\Forms\System\UnionDesc.pas' {UnionDescForm: TParentForm},
  CommonObjectDescProcedureTest in '..\SOURCE\ObjectDesc\CommonObjectDescProcedureTest.pas',
  UserKey in '..\..\Forms\Guides\UserKey.pas' {UserKeyForm: TParentForm},
  CommonObjectProcedureTest in '..\SOURCE\Objects\CommonObjectProcedureTest.pas',
  Goods in '..\..\FormsFarmacy\Guides\Goods.pas' {GoodsForm: TParentForm},
  UnitsTest in '..\SOURCE\Objects\All\Farmacy\UnitsTest.pas',
  UnitTree in '..\..\FormsFarmacy\Guides\UnitTree.pas' {UnitTreeForm: TParentForm},
  GoodsEdit in '..\..\FormsFarmacy\Guides\GoodsEdit.pas' {GoodsEditForm: TParentForm},
  GoodsMain in '..\..\FormsFarmacy\Guides\GoodsMain.pas' {GoodsMainForm: TParentForm},
  GoodsPartnerCode in '..\..\FormsFarmacy\Guides\GoodsPartnerCode.pas' {GoodsPartnerCodeForm: TParentForm},
  ImportSettingsTest in '..\SOURCE\Objects\All\ImportSettingsTest.pas',
  ExternalDocumentLoad in '..\..\SOURCE\COMPONENT\ExternalDocumentLoad.pas',
  ExternalLoadTest in '..\SOURCE\Component\ExternalLoadTest.pas',
  LoadObjectUnit in '..\..\FormsFarmacy\Guides\LoadObjectUnit.pas' {LoadObjectForm: TParentForm},
  OrderExternalTest in '..\SOURCE\Movement\All\OrderExternalTest.pas',
  dbMovementTest in '..\SOURCE\Movement\dbMovementTest.pas',
  CommonMovementProcedureTest in '..\SOURCE\Movement\CommonMovementProcedureTest.pas',
  PriceListMovementTest in '..\SOURCE\Movement\All\PriceListMovementTest.pas',
  OrderInternalTest in '..\SOURCE\Movement\All\OrderInternalTest.pas',
  ContractKindTest in '..\SOURCE\Objects\All\ContractKindTest.pas',
  ContractTest in '..\SOURCE\Objects\All\Farmacy\ContractTest.pas',
  Contract in '..\..\FormsFarmacy\Guides\Contract.pas' {ContractForm: TParentForm},
  ContractEdit in '..\..\FormsFarmacy\Guides\ContractEdit.pas' {ContractEditForm: TParentForm},
  PriceGroupSettingsTest in '..\SOURCE\Objects\All\Farmacy\PriceGroupSettingsTest.pas',
  PriceGroupSettingsUnit in '..\..\FormsFarmacy\Guides\PriceGroupSettingsUnit.pas' {PriceGroupSettingsForm: TParentForm},
  JuridicalSettingsTest in '..\SOURCE\Objects\All\JuridicalSettingsTest.pas',
  JuridicalSettings in '..\..\FormsFarmacy\Guides\JuridicalSettings.pas' {JuridicalSettingsForm: TParentForm},
  CommonProtocolProcedureTest in '..\SOURCE\Protocol\CommonProtocolProcedureTest.pas',
  ActionTest in '..\SOURCE\Objects\All\ActionTest.pas',
  Action in '..\..\Forms\Action.pas' {ActionForm: TParentForm},
  UserProtocol in '..\..\Forms\System\UserProtocol.pas' {UserProtocolForm: TParentForm},
  ImportGroupTest in '..\SOURCE\Objects\All\ImportGroupTest.pas',
  ImportGroupItemsTest in '..\SOURCE\Objects\All\ImportGroupItemsTest.pas',
  ImportSettings in '..\..\Forms\Import\ImportSettings.pas' {ImportSettingsForm: TParentForm},
  CommonMovementItemProcedureTest in '..\SOURCE\MovementItem\CommonMovementItemProcedureTest.pas',
  UploadUnloadData in '..\..\FormsFarmacy\ConnectWithOld\UploadUnloadData.pas' {dmUnloadUploadData: TDataModule},
  ContactPersonKind in '..\..\Forms\Kind\ContactPersonKind.pas' {ContactPersonKindForm: TParentForm},
  OrderKind in '..\..\Forms\Kind\OrderKind.pas' {OrderKindForm: TParentForm},
  ContactPersonEdit in '..\..\Forms\Guides\ContactPersonEdit.pas' {ContactPersonEditForm: TParentForm},
  ContactPersonTest in '..\SOURCE\Objects\All\ContactPersonTest.pas',
  PartnerCode in '..\..\FormsFarmacy\Guides\PartnerCode.pas' {PartnerCodeForm: TParentForm},
  GoodsLite in '..\..\FormsFarmacy\Guides\GoodsLite.pas' {GoodsLiteForm: TParentForm},
  ReportOrderGoods in '..\..\FormsFarmacy\Report\ReportOrderGoods.pas' {ReportOrderGoodsForm: TParentForm},
  LookAndFillSettings in '..\..\SOURCE\LookAndFillSettings.pas' {LookAndFillSettingsForm},
  ComDocXML in '..\..\SOURCE\EDI\ComDocXML.pas',
  DeclarXML in '..\..\SOURCE\EDI\DeclarXML.pas',
  DesadvXML in '..\..\SOURCE\EDI\DesadvXML.pas',
  EDI in '..\..\SOURCE\EDI\EDI.pas',
  InvoiceXML in '..\..\SOURCE\EDI\InvoiceXML.pas',
  OrderXML in '..\..\SOURCE\EDI\OrderXML.pas',
  OrdrspXML in '..\..\SOURCE\EDI\OrdrspXML.pas',
  dsdInternetAction in '..\..\SOURCE\COMPONENT\dsdInternetAction.pas',
  Member_Object in '..\..\Forms\Guides\Member_Object.pas' {Member_ObjectForm: TParentForm},
  MemberTest in '..\SOURCE\Objects\All\MemberTest.pas',
  Process in '..\..\Forms\Kind\Process.pas' {ProcessForm: TParentForm},
  NDSKindTest in '..\SOURCE\Objects\All\NDSKindTest.pas',
  AncestorMain in '..\..\Forms\Ancestor\AncestorMain.pas' {AncestorMainForm},
  IncomeTest in '..\SOURCE\Movement\All\Farmacy\IncomeTest.pas',
  IncomeMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\IncomeMovementItemTest.pas',
  ChoiceGoodsFromPriceList in '..\..\FormsFarmacy\System\ChoiceGoodsFromPriceList.pas' {ChoiceGoodsFromPriceListForm: TParentForm},
  OrderInternal in '..\..\FormsFarmacy\Document\OrderInternal.pas' {OrderInternalForm: TParentForm},
  OrderKindTest in '..\SOURCE\Objects\All\OrderKindTest.pas',
  ContactPerson in '..\..\Forms\Guides\ContactPerson.pas' {ContactPersonForm: TParentForm},
  OrderKindEdit in '..\..\Forms\Kind\OrderKindEdit.pas' {OrderKindEditForm: TParentForm},
  ImportExportLinkTest in '..\SOURCE\Objects\All\ImportExportLinkTest.pas',
  SetUserDefaults in '..\..\Forms\System\SetUserDefaults.pas' {SetUserDefaultsForm: TParentForm},
  Protocol in '..\..\Forms\System\Protocol.pas' {ProtocolForm: TParentForm},
  MovementProtocol in '..\..\Forms\System\MovementProtocol.pas' {MovementProtocolForm: TParentForm},
  ImportExportLinkTypeTest in '..\SOURCE\Objects\All\ImportExportLinkTypeTest.pas',
  NDSKind in '..\..\Forms\Kind\NDSKind.pas' {NDSKindForm: TParentForm},
  ComponentDBTest in '..\SOURCE\Component\ComponentDBTest.pas',
  BankAccount in '..\..\Forms\Guides\BankAccount.pas' {BankAccountForm: TParentForm},
  BankAccountEdit in '..\..\Forms\Guides\BankAccountEdit.pas' {BankAccountEditForm: TParentForm},
  Bank in '..\..\Forms\Bank.pas' {BankForm: TParentForm},
  BankAccountTest in '..\SOURCE\Objects\All\BankAccountTest.pas',
  BankTest in '..\SOURCE\Objects\All\BankTest.pas',
  CurrencyTest in '..\SOURCE\Objects\All\CurrencyTest.pas',
  dsdDataSetDataLink in '..\..\SOURCE\COMPONENT\dsdDataSetDataLink.pas',
  dsdXMLTransform in '..\..\SOURCE\COMPONENT\dsdXMLTransform.pas',
  BankAccount_Object in '..\..\Forms\Guides\BankAccount_Object.pas' {BankAccount_ObjectForm: TParentForm},
  BankEdit in '..\..\Forms\BankEdit.pas' {BankEditForm: TParentForm},
  Juridical_Object in '..\..\FormsFarmacy\Guides\Juridical_Object.pas' {Juridical_ObjectForm: TParentForm},
  Currency in '..\..\Forms\Guides\Currency.pas' {CurrencyForm: TParentForm},
  Currency_Object in '..\..\Forms\Guides\Currency_Object.pas' {Currency_ObjectForm: TParentForm},
  CurrencyEdit in '..\..\Forms\Guides\CurrencyEdit.pas' {CurrencyEditForm: TParentForm},
  CurrencyValue_Object in '..\..\Forms\Guides\CurrencyValue_Object.pas' {CurrencyValue_ObjectForm: TParentForm},
  Account in '..\..\Forms\Guides\Account.pas' {AccountForm: TParentForm},
  Account_Object in '..\..\Forms\Guides\Account_Object.pas' {Account_ObjectForm: TParentForm},
  AccountDirection in '..\..\Forms\Guides\AccountDirection.pas' {AccountDirectionForm: TParentForm},
  AccountDirection_Object in '..\..\Forms\Guides\AccountDirection_Object.pas' {AccountDirection_ObjectForm: TParentForm},
  AccountDirectionEdit in '..\..\Forms\Guides\AccountDirectionEdit.pas' {AccountDirectionEditForm: TParentForm},
  AccountEdit in '..\..\Forms\Guides\AccountEdit.pas' {AccountEditForm: TParentForm},
  AccountGroup in '..\..\Forms\Guides\AccountGroup.pas' {AccountGroupForm: TParentForm},
  AccountGroup_Object in '..\..\Forms\Guides\AccountGroup_Object.pas' {AccountGroup_ObjectForm: TParentForm},
  AccountGroupEdit in '..\..\Forms\Guides\AccountGroupEdit.pas' {AccountGroupEditForm: TParentForm},
  AccountDirectionTest in '..\SOURCE\Objects\All\AccountDirectionTest.pas',
  AccountGroupTest in '..\SOURCE\Objects\All\AccountGroupTest.pas',
  AccountTest in '..\SOURCE\Objects\All\AccountTest.pas',
  InfoMoneyDestinationTest in '..\SOURCE\Objects\All\InfoMoneyDestinationTest.pas',
  InfoMoneyGroupTest in '..\SOURCE\Objects\All\InfoMoneyGroupTest.pas',
  InfoMoneyTest in '..\SOURCE\Objects\All\InfoMoneyTest.pas',
  InfoMoney in '..\..\Forms\Guides\InfoMoney.pas' {InfoMoneyForm: TParentForm},
  InfoMoneyDestination in '..\..\Forms\Guides\InfoMoneyDestination.pas' {InfoMoneyDestinationForm: TParentForm},
  InfoMoneyDestination_Object in '..\..\Forms\Guides\InfoMoneyDestination_Object.pas' {InfoMoneyDestination_ObjectForm: TParentForm},
  InfoMoneyDestinationEdit in '..\..\Forms\Guides\InfoMoneyDestinationEdit.pas' {InfoMoneyDestinationEditForm: TParentForm},
  InfoMoneyEdit in '..\..\Forms\Guides\InfoMoneyEdit.pas' {InfoMoneyEditForm: TParentForm},
  InfoMoneyGroup in '..\..\Forms\Guides\InfoMoneyGroup.pas' {InfoMoneyGroupForm: TParentForm},
  InfoMoneyGroup_Object in '..\..\Forms\Guides\InfoMoneyGroup_Object.pas' {InfoMoneyGroup_ObjectForm: TParentForm},
  InfoMoneyGroupEdit in '..\..\Forms\Guides\InfoMoneyGroupEdit.pas' {InfoMoneyGroupEditForm: TParentForm},
  ProfitLossDirectionTest in '..\SOURCE\Objects\All\ProfitLossDirectionTest.pas',
  ProfitLossGroupTest in '..\SOURCE\Objects\All\ProfitLossGroupTest.pas',
  ProfitLossTest in '..\SOURCE\Objects\All\ProfitLossTest.pas',
  ProfitLoss in '..\..\Forms\Guides\ProfitLoss.pas' {ProfitLossForm: TParentForm},
  ProfitLoss_Object in '..\..\Forms\Guides\ProfitLoss_Object.pas' {ProfitLoss_ObjectForm: TParentForm},
  ProfitLossDirection in '..\..\Forms\Guides\ProfitLossDirection.pas' {ProfitLossDirectionForm: TParentForm},
  ProfitLossDirection_Object in '..\..\Forms\Guides\ProfitLossDirection_Object.pas' {ProfitLossDirection_ObjectForm: TParentForm},
  ProfitLossDirectionEdit in '..\..\Forms\Guides\ProfitLossDirectionEdit.pas' {ProfitLossDirectionEditForm: TParentForm},
  ProfitLossEdit in '..\..\Forms\Guides\ProfitLossEdit.pas' {ProfitLossEditForm: TParentForm},
  ProfitLossGroup in '..\..\Forms\Guides\ProfitLossGroup.pas' {ProfitLossGroupForm: TParentForm},
  ProfitLossGroup_Object in '..\..\Forms\Guides\ProfitLossGroup_Object.pas' {ProfitLossGroup_ObjectForm: TParentForm},
  ProfitLossGroupEdit in '..\..\Forms\Guides\ProfitLossGroupEdit.pas' {ProfitLossGroupEditForm: TParentForm},
  ReturnTypeTest in '..\SOURCE\Objects\All\ReturnTypeTest.pas',
  ReturnType in '..\..\Forms\Kind\ReturnType.pas' {ReturnTypeForm: TParentForm},
  ReturnTypeEdit in '..\..\Forms\Kind\ReturnTypeEdit.pas' {ReturnTypeEditForm: TParentForm},
  LossDebtTest in '..\SOURCE\Movement\All\Farmacy\LossDebtTest.pas',
  LossDebtMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\LossDebtMovementItemTest.pas',
  LossDebt in '..\..\FormsFarmacy\Document\LossDebt.pas' {LossDebtForm: TParentForm},
  LossDebtJournal in '..\..\FormsFarmacy\Document\LossDebtJournal.pas' {LossDebtJournalForm: TParentForm},
  MovementItemContainer in '..\..\Forms\System\MovementItemContainer.pas' {MovementItemContainerForm: TParentForm},
  Report_Balance in '..\..\Forms\Report\Report_Balance.pas' {Report_BalanceForm: TParentForm},
  ReturnOutJournal in '..\..\FormsFarmacy\Document\ReturnOutJournal.pas' {ReturnOutJournalForm: TParentForm},
  ReturnOutTest in '..\SOURCE\Movement\All\Farmacy\ReturnOutTest.pas',
  IncomeJournalChoice in '..\..\FormsFarmacy\Document\IncomeJournalChoice.pas' {IncomeJournalChoiceForm: TParentForm},
  BankAccountJournal in '..\..\Forms\Document\BankAccountJournal.pas' {BankAccountJournalForm: TParentForm},
  BankAccountMovement in '..\..\Forms\Document\BankAccountMovement.pas' {BankAccountMovementForm: TParentForm},
  BankAccountJournalFarmacy in '..\..\FormsFarmacy\Document\BankAccountJournalFarmacy.pas' {BankAccountJournalFarmacyForm},
  BankAccountMovementFarmacy in '..\..\FormsFarmacy\Document\BankAccountMovementFarmacy.pas' {BankAccountMovementFarmacyForm: TParentForm},
  BankAccountMovementTest in '..\SOURCE\Movement\All\Farmacy\BankAccountMovementTest.pas',
  InfoMoney_Object in '..\..\Forms\Guides\InfoMoney_Object.pas' {InfoMoney_ObjectForm: TParentForm},
  MoneyPlace_Object in '..\..\FormsFarmacy\Guides\MoneyPlace_Object.pas' {MoneyPlace_ObjectForm: TParentForm},
  BankStatement in '..\..\FormsFarmacy\Document\BankStatement.pas' {BankStatementForm: TParentForm},
  BankStatementJournal in '..\..\FormsFarmacy\Document\BankStatementJournal.pas' {BankStatementJournalForm: TParentForm},
  BankStatementTest in '..\SOURCE\Movement\All\BankStatementTest.pas',
  BankStatementItemTest in '..\SOURCE\Movement\All\BankStatementItemTest.pas',
  Report_JuridicalCollation in '..\..\FormsFarmacy\Report\Report_JuridicalCollation.pas' {Report_JuridicalCollationForm: TParentForm},
  Report_JuridicalSold in '..\..\FormsFarmacy\Report\Report_JuridicalSold.pas' {Report_JuridicalSoldForm: TParentForm},
  StatusXML in '..\..\SOURCE\EDI\StatusXML.pas',
  SendOnPrice in '..\..\FormsFarmacy\Document\SendOnPrice.pas' {SendOnPriceForm: TParentForm},
  SendOnPriceJournal in '..\..\FormsFarmacy\Document\SendOnPriceJournal.pas' {SendOnPriceJournalForm: TParentForm},
  MarginCategory in '..\..\Forms\Guides\MarginCategory.pas' {MarginCategoryForm: TParentForm},
  MarginCategoryItem in '..\..\Forms\Guides\MarginCategoryItem.pas' {MarginCategoryItemForm: TParentForm},
  MarginCategoryLink in '..\..\Forms\Guides\MarginCategoryLink.pas' {MarginCategoryLinkForm: TParentForm},
  dsdException in '..\..\SOURCE\dsdException.pas',
  MovementDescForms in '..\..\Forms\System\MovementDescForms.pas' {MovementDescDataForm: TParentForm},
  IncomePharmacy in '..\..\FormsFarmacy\Document\IncomePharmacy.pas' {IncomePharmacyForm: TParentForm},
  IncomePharmacyJournal in '..\..\FormsFarmacy\Document\IncomePharmacyJournal.pas' {IncomePharmacyJournalForm: TParentForm},
  LoadFarmacyReportTest in '..\SOURCE\LoadFarmacyReportTest.pas',
  CheckJournal in '..\..\Forms\Document\CheckJournal.pas' {CheckJournalForm: TParentForm},
  Check in '..\..\Forms\Document\Check.pas' {CheckForm: TParentForm},
  CashRegisterKind in '..\..\Forms\Kind\CashRegisterKind.pas' {CashRegisterKindForm: TParentForm},
  CashRegister in '..\..\Forms\Guides\CashRegister.pas' {CashRegisterForm: TParentForm},
  CashRegisterEdit in '..\..\Forms\Guides\CashRegisterEdit.pas' {CashRegisterEditForm: TParentForm},
  AncestorReport in '..\..\Forms\Ancestor\AncestorReport.pas' {AncestorReportForm: TParentForm},
  Report_RemainGoods in '..\..\FormsFarmacy\Report\Report_RemainGoods.pas' {Report_GoodsRemainsForm: TParentForm},
  Report_GoodsPartionMove in '..\..\FormsFarmacy\Report\Report_GoodsPartionMove.pas' {Report_GoodsPartionMoveForm: TParentForm},
  PriceTest in '..\SOURCE\Objects\All\Farmacy\PriceTest.pas',
  AlternativeGroupTest in '..\SOURCE\Objects\All\Farmacy\AlternativeGroupTest.pas',
  AlternativeGroup in '..\..\FormsFarmacy\Guides\AlternativeGroup.pas' {AlternativeGroupForm: TParentForm},
  RepriceUnit in '..\..\FormsFarmacy\ConnectWithOld\RepriceUnit.pas' {RepriceUnitForm},
  CheckVIP in '..\..\FormsFarmacy\Document\CheckVIP.pas' {CheckVIPForm: TParentForm},
  CheckDeferred in '..\..\FormsFarmacy\Document\CheckDeferred.pas' {CheckDeferredForm: TParentForm},
  PaidType in '..\..\Forms\Guides\PaidType.pas' {PaidTypeForm: TParentForm},
  PaidTypeTest in '..\SOURCE\Objects\All\Farmacy\PaidTypeTest.pas',
  CashRegisterTest in '..\SOURCE\Objects\All\Farmacy\CashRegisterTest.pas',
  InventoryTest in '..\SOURCE\Movement\All\Farmacy\InventoryTest.pas',
  Inventory in '..\..\FormsFarmacy\Document\Inventory.pas' {InventoryForm: TParentForm},
  InventoryJournal in '..\..\FormsFarmacy\Document\InventoryJournal.pas' {InventoryJournalForm: TParentForm},
  InventoryMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\InventoryMovementItemTest.pas',
  LossTest in '..\SOURCE\Movement\All\Farmacy\LossTest.pas',
  LossMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\LossMovementItemTest.pas',
  ArticleLossTest in '..\SOURCE\Objects\All\Farmacy\ArticleLossTest.pas',
  Loss in '..\..\FormsFarmacy\Document\Loss.pas' {LossForm: TParentForm},
  LossJournal in '..\..\FormsFarmacy\Document\LossJournal.pas' {LossJournalForm: TParentForm},
  ArticleLoss in '..\..\Forms\Guides\ArticleLoss.pas' {ArticleLossForm: TParentForm},
  ArticleLossEdit in '..\..\Forms\Guides\ArticleLossEdit.pas' {ArticleLossEditForm: TParentForm},
  Send in '..\..\FormsFarmacy\Document\Send.pas' {SendForm: TParentForm},
  SendJournal in '..\..\FormsFarmacy\Document\SendJournal.pas' {SendJournalForm: TParentForm},
  SendTest in '..\SOURCE\Movement\All\Farmacy\SendTest.pas',
  SendMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\SendMovementItemTest.pas',
  CreateOrderFromMCS in '..\..\FormsFarmacy\Document\CreateOrderFromMCS.pas' {CreateOrderFromMCSForm: TParentForm},
  CheckJournalUser in '..\..\Forms\Document\CheckJournalUser.pas' {CheckJournalUserForm: TParentForm},
  MCS in '..\..\Forms\Guides\MCS.pas' {MCSForm: TParentForm},
  PartionGoodsChoice in '..\..\Forms\Guides\PartionGoodsChoice.pas' {PartionGoodsChoiceForm: TParentForm},
  Report_GoodsPartionHistory in '..\..\FormsFarmacy\Report\Report_GoodsPartionHistory.pas' {Report_GoodsPartionHistoryForm: TParentForm},
  RecalcMCS_Dialog in '..\..\FormsFarmacy\System\RecalcMCS_Dialog.pas' {RecalcMCS_DialogForm: TParentForm},
  ReportSoldParams in '..\..\FormsFarmacy\Object\ReportSoldParams.pas' {ReportSoldParamsForm: TParentForm},
  ReportSoldParamsTest in '..\SOURCE\Objects\All\Farmacy\ReportSoldParamsTest.pas',
  Report_Sold in '..\..\FormsFarmacy\Report\Report_Sold.pas' {Report_SoldForm: TParentForm},
  Report_Sold_Day in '..\..\FormsFarmacy\Report\Report_Sold_Day.pas' {Report_Sold_DayForm: TParentForm},
  Report_Sold_DayUser in '..\..\FormsFarmacy\Report\Report_Sold_DayUser.pas' {Report_Sold_DayUserForm: TParentForm},
  RecadvXML in '..\..\SOURCE\EDI\RecadvXML.pas',
  AdditionalGoodsTest in '..\SOURCE\Objects\All\Farmacy\AdditionalGoodsTest.pas',
  SaleTest in '..\SOURCE\Movement\All\Farmacy\SaleTest.pas',
  SaleMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\SaleMovementItemTest.pas',
  SaleJournal in '..\..\FormsFarmacy\Document\SaleJournal.pas' {SaleJournalForm: TParentForm},
  Sale in '..\..\FormsFarmacy\Document\Sale.pas' {SaleForm: TParentForm},
  PaidKind in '..\..\Forms\Kind\PaidKind.pas' {PaidKindForm: TParentForm},
  Report_Movement_ByPartionGoods in '..\..\FormsFarmacy\Report\Report_Movement_ByPartionGoods.pas' {Report_Movement_ByPartionGoodsForm: TParentForm},
  PaymentTest in '..\SOURCE\Movement\All\Farmacy\PaymentTest.pas',
  PaymentMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\PaymentMovementItemTest.pas',
  Payment in '..\..\FormsFarmacy\Document\Payment.pas' {PaymentForm: TParentForm},
  PaymentJournal in '..\..\FormsFarmacy\Document\PaymentJournal.pas' {PaymentJournalForm: TParentForm},
  JuridicalCorporate in '..\..\FormsFarmacy\Guides\JuridicalCorporate.pas' {JuridicalCorporateForm: TParentForm},
  ReasonDifferences in '..\..\FormsFarmacy\Guides\ReasonDifferences.pas' {ReasonDifferencesForm: TParentForm},
  ReasonDifferencesTest in '..\SOURCE\Objects\All\Farmacy\ReasonDifferencesTest.pas',
  Income_AmountTrouble in '..\..\FormsFarmacy\Document\Income_AmountTrouble.pas' {Income_AmountTroubleForm: TParentForm},
  Report_UploadBaDM in '..\..\FormsFarmacy\Report\Report_UploadBaDM.pas' {Report_UploadBaDMForm: TParentForm},
  Report_UploadOptima in '..\..\FormsFarmacy\Report\Report_UploadOptima.pas' {Report_UploadOptimaForm: TParentForm},
  RepriceTest in '..\SOURCE\Movement\All\Farmacy\RepriceTest.pas',
  RepriceMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\RepriceMovementItemTest.pas',
  RepriceJournal in '..\..\FormsFarmacy\Document\RepriceJournal.pas' {RepriceJournalForm: TParentForm},
  Reprice in '..\..\FormsFarmacy\Document\Reprice.pas' {RepriceForm: TParentForm},
  ChangeIncomePaymentKindTest in '..\SOURCE\Objects\All\Farmacy\ChangeIncomePaymentKindTest.pas',
  ChangeIncomePaymentKind in '..\..\FormsFarmacy\Guides\ChangeIncomePaymentKind.pas' {ChangeIncomePaymentKindForm: TParentForm},
  ChangeIncomePaymentTest in '..\SOURCE\Movement\All\Farmacy\ChangeIncomePaymentTest.pas',
  ChangeIncomePaymentJournal in '..\..\FormsFarmacy\Document\ChangeIncomePaymentJournal.pas' {ChangeIncomePaymentJournalForm: TParentForm},
  ChangeIncomePayment in '..\..\FormsFarmacy\Document\ChangeIncomePayment.pas' {ChangeIncomePaymentForm: TParentForm},
  PriceHistory in '..\..\FormsFarmacy\Guides\PriceHistory.pas' {PriceHistoryForm: TParentForm},
  ReturnOutPartnerDataDialog in '..\..\FormsFarmacy\Document\ReturnOutPartnerDataDialog.pas' {ReturnOutPartnerDataDialogForm: TParentForm},
  IncomePartnerDataDialog in '..\..\FormsFarmacy\Document\IncomePartnerDataDialog.pas' {IncomePartnerDataDialogForm: TParentForm},
  PersonalGroupEdit in '..\..\FormsFarmacy\Guides\PersonalGroupEdit.pas' {PersonalGroupEditForm: TParentForm},
  PersonalGroup in '..\..\FormsFarmacy\Guides\PersonalGroup.pas' {PersonalGroupForm: TParentForm},
  PersonalEdit in '..\..\FormsFarmacy\Guides\PersonalEdit.pas' {PersonalEditForm: TParentForm},
  Personal_Object in '..\..\FormsFarmacy\Guides\Personal_Object.pas' {Personal_ObjectForm: TParentForm},
  Personal in '..\..\FormsFarmacy\Guides\Personal.pas' {PersonalForm: TParentForm},
  Education in '..\..\FormsFarmacy\Guides\Education.pas' {EducationForm: TParentForm},
  EducationEdit in '..\..\FormsFarmacy\Guides\EducationEdit.pas' {EducationEditForm: TParentForm},
  Position in '..\..\FormsFarmacy\Guides\Position.pas' {PositionForm: TParentForm},
  PositionEdit in '..\..\FormsFarmacy\Guides\PositionEdit.pas' {PositionEditForm: TParentForm},
  Calendar in '..\..\FormsFarmacy\Guides\Calendar.pas' {CalendarForm: TParentForm},
  WorkTimeKind_Object in '..\..\FormsFarmacy\Kind\WorkTimeKind_Object.pas' {WorkTimeKind_ObjectForm: TParentForm},
  WorkTimeKind in '..\..\FormsFarmacy\Kind\WorkTimeKind.pas' {WorkTimeKindForm: TParentForm},
  Member in '..\..\FormsFarmacy\Guides\Member.pas' {MemberForm: TParentForm},
  MemberEdit in '..\..\FormsFarmacy\Guides\MemberEdit.pas' {MemberEditForm: TParentForm},
  SheetWorkTimeJournal in '..\..\FormsFarmacy\Document\SheetWorkTimeJournal.pas' {SheetWorkTimeJournalForm: TParentForm},
  SheetWorkTime in '..\..\FormsFarmacy\Document\SheetWorkTime.pas' {SheetWorkTimeForm: TParentForm},
  Report_MovementIncome in '..\..\FormsFarmacy\Report\Report_MovementIncome.pas' {Report_MovementIncomeForm: TParentForm},
  SheetWorkTimeAddRecord in '..\..\FormsFarmacy\Document\SheetWorkTimeAddRecord.pas' {SheetWorkTimeAddRecordForm: TParentForm},
  GoodsGroup in '..\..\FormsFarmacy\Guides\GoodsGroup.pas' {GoodsGroupForm: TParentForm},
  GoodsGroupEdit in '..\..\FormsFarmacy\Guides\GoodsGroupEdit.pas' {GoodsGroupEditForm: TParentForm},
  GoodsGroup_Object in '..\..\FormsFarmacy\Guides\GoodsGroup_Object.pas' {GoodsGroup_ObjectForm: TParentForm},
  Report_LiquidDialog in '..\..\FormsFarmacy\Report\Report_LiquidDialog.pas' {Report_LiquidDialogForm: TParentForm},
  Report_Wage in '..\..\FormsFarmacy\Report\Report_Wage.pas' {Report_WageForm: TParentForm},
  Report_WageDialog in '..\..\FormsFarmacy\Report\Report_WageDialog.pas' {Report_WageDialogForm: TParentForm},
  PriceDialog in '..\..\FormsFarmacy\Guides\PriceDialog.pas' {PriceDialogForm: TParentForm},
  GoodsAll in '..\..\FormsFarmacy\Guides\GoodsAll.pas' {GoodsAllForm: TParentForm},
  GoodsAllJuridical in '..\..\FormsFarmacy\Guides\GoodsAllJuridical.pas' {GoodsAllJuridicalForm: TParentForm},
  GoodsAllRetail in '..\..\FormsFarmacy\Guides\GoodsAllRetail.pas' {GoodsAllRetailForm: TParentForm},
  EmailKind in '..\..\FormsFarmacy\Kind\EmailKind.pas' {EmailKindForm: TParentForm},
  EmailTools in '..\..\FormsFarmacy\Kind\EmailTools.pas' {EmailToolsForm: TParentForm},
  EmailSettings in '..\..\FormsFarmacy\Guides\EmailSettings.pas' {EmailSettingsForm: TParentForm},
  Movement_PeriodDialog in '..\..\FormsFarmacy\Document\Movement_PeriodDialog.pas' {Movement_PeriodDialogForm: TParentForm},
  Report_Liquid in '..\..\FormsFarmacy\Report\Report_Liquid.pas' {Report_LiquidForm: TParentForm},
  PriceOnDate in '..\..\FormsFarmacy\Guides\PriceOnDate.pas' {PriceOnDateForm: TParentForm},
  BankAccountJournalFarmacyDialog in '..\..\FormsFarmacy\Document\BankAccountJournalFarmacyDialog.pas' {BankAccountJournalFarmacyDialogForm: TParentForm},
  QualityNumberJournal in '..\..\Forms\Document\QualityNumberJournal.pas' {QualityNumberJournalForm: TParentForm},
  QualityNumber in '..\..\Forms\Document\QualityNumber.pas' {QualityNumberForm: TParentForm},
  Report_Profit in '..\..\FormsFarmacy\Report\Report_Profit.pas' {Report_ProfitForm: TParentForm},
  Report_ProfitDialog in '..\..\FormsFarmacy\Report\Report_ProfitDialog.pas' {Report_ProfitDialogForm: TParentForm},
  Report_PriceInterventionDialog in '..\..\FormsFarmacy\Report\Report_PriceInterventionDialog.pas' {Report_PriceInterventionDialogForm: TParentForm},
  Report_MovementCheckDialog in '..\..\FormsFarmacy\Report\Report_MovementCheckDialog.pas' {Report_MovementCheckDialogForm: TParentForm},
  Report_RemainGoodsDialog in '..\..\FormsFarmacy\Report\Report_RemainGoodsDialog.pas' {Report_GoodsRemainsDialogForm: TParentForm},
  Report_MovementCheckFarmDialog in '..\..\FormsFarmacy\Report\Report_MovementCheckFarmDialog.pas' {Report_MovementCheckFarmDialogForm: TParentForm},
  ReportMovementCheckFarm in '..\..\FormsFarmacy\Report\ReportMovementCheckFarm.pas' {ReportMovementCheckFarmForm: TParentForm},
  Report_PriceIntervention in '..\..\FormsFarmacy\Report\Report_PriceIntervention.pas' {Report_PriceInterventionForm: TParentForm},
  Report_MovementIncomeDialog in '..\..\FormsFarmacy\Report\Report_MovementIncomeDialog.pas' {Report_MovementIncomeDialogForm: TParentForm},
  MarginReport in '..\..\FormsFarmacy\Guides\MarginReport.pas' {MarginReportForm: TParentForm},
  MarginReportItem in '..\..\FormsFarmacy\Guides\MarginReportItem.pas' {MarginReportItemForm: TParentForm},
  Report_MovementIncomeFarmDialog in '..\..\FormsFarmacy\Report\Report_MovementIncomeFarmDialog.pas' {Report_MovementIncomeFarmDialogForm: TParentForm},
  Report_MovementIncomeFarm in '..\..\FormsFarmacy\Report\Report_MovementIncomeFarm.pas' {Report_MovementIncomeFarmForm: TParentForm},
  Report_PriceIntervention2 in '..\..\FormsFarmacy\Report\Report_PriceIntervention2.pas' {Report_PriceIntervention2Form: TParentForm},
  ReturnOut in '..\..\FormsFarmacy\Document\ReturnOut.pas' {ReturnOutForm: TParentForm},
  ChoiceGoodsFromRemains in '..\..\FormsFarmacy\System\ChoiceGoodsFromRemains.pas' {ChoiceGoodsFromRemainsForm: TParentForm},
  Report_GoodsOnUnit_ForSite in '..\..\FormsFarmacy\Report\Report_GoodsOnUnit_ForSite.pas' {Report_GoodsOnUnit_ForSiteForm: TParentForm},
  Report_GoodsOnUnit_ForSiteDialog in '..\..\FormsFarmacy\Report\Report_GoodsOnUnit_ForSiteDialog.pas' {Report_GoodsOnUnit_ForSiteDialogForm: TParentForm},
  Report_MovementCheckMiddleDialog in '..\..\FormsFarmacy\Report\Report_MovementCheckMiddleDialog.pas' {Report_MovementCheckMiddleDialogForm: TParentForm},
  ReportMovementCheck in '..\..\FormsFarmacy\Report\ReportMovementCheck.pas' {ReportMovementCheckForm: TParentForm},
  OrderExternalJournalChoice in '..\..\FormsFarmacy\Document\OrderExternalJournalChoice.pas' {OrderExternalJournalChoiceForm: TParentForm},
  Income in '..\..\FormsFarmacy\Document\Income.pas' {IncomeForm: TParentForm},
  Maker in '..\..\Forms\Guides\Maker.pas' {MakerForm: TParentForm},
  MakerEdit in '..\..\Forms\Guides\MakerEdit.pas' {MakerEditForm: TParentForm},
  Promo in '..\..\FormsFarmacy\Document\Promo.pas' {PromoForm: TParentForm},
  PromoJournal in '..\..\FormsFarmacy\Document\PromoJournal.pas' {PromoJournalForm: TParentForm},
  ReportMovementCheckMiddle in '..\..\FormsFarmacy\Report\ReportMovementCheckMiddle.pas' {ReportMovementCheckMiddleForm: TParentForm},
  Unit_Object in '..\..\FormsFarmacy\Guides\Unit_Object.pas' {Unit_ObjectForm: TParentForm},
  Report_RemainsOverGoodsDialog in '..\..\FormsFarmacy\Report\Report_RemainsOverGoodsDialog.pas' {Report_RemainsOverGoodsDialogForm: TParentForm},
  MovementItemProtocol in '..\..\Forms\System\MovementItemProtocol.pas' {MovementItemProtocolForm: TParentForm},
  UnitForFarmacyCash in '..\..\FormsFarmacy\Guides\UnitForFarmacyCash.pas' {UnitForFarmacyCashForm: TParentForm},
  Report_GoodsPartionMoveDialog in '..\..\FormsFarmacy\Report\Report_GoodsPartionMoveDialog.pas' {Report_GoodsPartionMoveDialogForm: TParentForm},
  Email in '..\..\FormsFarmacy\Guides\Email.pas' {EmailForm: TParentForm},
  EmailEdit in '..\..\FormsFarmacy\Guides\EmailEdit.pas' {EmailEditForm: TParentForm},
  Price in '..\..\FormsFarmacy\Guides\Price.pas' {PriceForm: TParentForm},
  Report_GoodsPartionHistoryDialog in '..\..\FormsFarmacy\Report\Report_GoodsPartionHistoryDialog.pas' {Report_GoodsPartionHistoryDialogForm: TParentForm},
  Over in '..\..\FormsFarmacy\Document\Over.pas' {OverForm: TParentForm},
  OverJournal in '..\..\FormsFarmacy\Document\OverJournal.pas' {OverJournalForm: TParentForm},
  RoleUnion in '..\..\Forms\RoleUnion.pas' {RoleUnionForm: TParentForm},
  Report_RemainsOverGoods in '..\..\FormsFarmacy\Report\Report_RemainsOverGoods.pas' {Report_RemainsOverGoodsForm: TParentForm},
  PriceGoodsDialog in '..\..\FormsFarmacy\Guides\PriceGoodsDialog.pas' {PriceGoodsDialogForm: TParentForm},
  Color in '..\..\FormsFarmacy\System\Color.pas' {ColorForm: TParentForm},
  OverSettingsEdit in '..\..\FormsFarmacy\Guides\OverSettingsEdit.pas' {OverSettingsEditForm: TParentForm},
  OverSettings in '..\..\FormsFarmacy\Guides\OverSettings.pas' {OverSettingsForm: TParentForm},
  DiscountExternalEdit in '..\..\FormsFarmacy\Guides\DiscountExternalEdit.pas' {DiscountExternalEditForm: TParentForm},
  DiscountCard in '..\..\FormsFarmacy\Guides\DiscountCard.pas' {DiscountCardForm: TParentForm},
  BarCodeEdit in '..\..\FormsFarmacy\Guides\BarCodeEdit.pas' {BarCodeEditForm: TParentForm},
  BarCode in '..\..\FormsFarmacy\Guides\BarCode.pas' {BarCodeForm: TParentForm},
  DiscountExternal in '..\..\FormsFarmacy\Guides\DiscountExternal.pas' {DiscountExternalForm: TParentForm},
  DiscountCardEdit in '..\..\FormsFarmacy\Guides\DiscountCardEdit.pas' {DiscountCardEditForm: TParentForm};

{$R *.res}
{$R DevExpressRus.res}

begin
  ConnectionPath := '..\INIT\farmacy_init.php';
  EnumPath := '..\DATABASE\FARMACY\METADATA\Enum\';
  CreateStructurePath := '..\DATABASE\FARMACY\STRUCTURE\';
  LocalViewPath := '..\DATABASE\FARMACY\View\';
  LocalProcedurePath := '..\DATABASE\FARMACY\PROCEDURE\';
  LocalProcessPath := '..\DATABASE\COMMON\PROCESS\';
  dsdProject := prFarmacy;

  if FindCmdLineSwitch('realfarmacy', true)
  then gc_AdminPassword := '�����1234'
  else gc_AdminPassword := '�����1111';

  gc_ProgramName := 'Farmacy.exe';

  Application.Initialize;
  gc_isSetDefault := true;
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;

  DUnitTestRunner.RunRegisteredTests;
end.
