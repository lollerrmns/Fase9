import { LightningElement, track, api, wire } from "lwc";
import objContasAtivas from "@salesforce/apex/ControllerFaseNove.listaContasAtivas";
import objColabsProj from "@salesforce/apex/ControllerFaseNove.listaContasDoProjeto";
import objGravar from "@salesforce/apex/ControllerFaseNove.gravar";
import idProj from "@salesforce/apex/ControllerFaseNove.getProjectId";

export default class Projeto_fase_9 extends LightningElement {
  padrao = true;
  _selected = ["1"];
  _projeto = "";
  listOptions = [
    // { value: "1", label: "Option 1" },
    //{ value: "2", label: "Option 2" },
  ];
  defaultOptions = [
    //"1"
  ];
  requiredOptions = [];

  @api recordId;

  @wire(idProj, { idd: "$recordId" })
  retornoIdProj({ error, data }) {
    if (error) {
      console.log("Error Data");
    } else if (data) {
      console.log("Projeto OK");
      console.log("DATA = " + data);
      this._projeto = String(data);
    }
  }

  @wire(objContasAtivas, { idd: "$recordId" })
  retornoContasAtivas({ error, data }) {
    if (error) {
      console.log("Error Data");
    } else if (data) {
      console.log("Contas Ativas OK");
      data.forEach((element) => {
        //console.log('MUAMBA'+element.Name);
        this.listOptions.push({
          value: String(element.Id),
          label: String(element.Name),
        });
      });
    }
  }
  @wire(objColabsProj, { idd: "$recordId" })
  retornoContasProj({ error, data }) {
    if (error) {
      console.log("Error Data");
    } else if (data) {
      console.log("Contas Projeto OK");
      data.forEach((element) => {
        this.defaultOptions.push(String(element.Id));
      });
    }
  }

  get selected() {
    if (this._selected.length) {
      return this._selected;
    } else {
      return "NADA";
    }
  }

  handleChange(event) {
    this.padrao = false;
    this._selected = event.detail.value;
  }
  @track isModalOpen = false;
  openModal() {
    this.isModalOpen = true;

    this._selected = [];
    padrao = true;
  }
  closeModal() {
    this.isModalOpen = false;
  }
  submitDetails() {
    this.isModalOpen = false;
    
    if (this.padrao) {
      //alert("PADRÃO " + this.defaultOptions);
    } else {
      objGravar({ pListId: this._selected, pIdProjeto: this._projeto })
      .then((result) => {
        console.log("OK" + result);
        console.dir(result);
      })
      .catch((error) => {
        this.error = error;
      });
      alert("Cadastro alterado,\n por favor recarregue a página \n\n" + this._selected);
    }
  }
}