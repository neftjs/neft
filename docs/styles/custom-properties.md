# Custom Properties


```javascript
Item {
    property $.health: 100
    signal $.onAttack
    signal $.onLowHealth
    $.onAttack: function(target){
        this.$.health -= target.$.attack;
        if (this.$.health < 40){
            this.$.onLowHealth.emit();
        }
    }
}
```

Custom properties and signals must be created in the `$` object.

Custom properties have their corresponding signals (e.g. `$.onHealthChange`).


