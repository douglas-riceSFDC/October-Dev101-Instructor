import { LightningElement } from 'lwc';
import passingMaps from '@salesforce/apex/StylePlaygroundController/passingMaps';

export default class StylePlayground extends LightningElement {
    value = 'inProgress';

    textInput = '';
    mapInput = {};

    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

    sendEvent(event) {
        //let dataElement = event.currentTarget.dataset.name;

        
    }
}