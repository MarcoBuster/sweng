# Mocked Construction

Durante il testing di determinate funzioni potremmo trovarci di fronte alla necessità di modificare la classe per poterlo fare. Ad esempio gli attributi __final__ appartenenti a una classe, che non ci permettono di essere riassegnati, rendono impossibile l'inizione di oggetti __mockati__ al loro interno. Una soluzione possibile è quella di togliere l'attributo __final__ solamente ai fini del nostro testing. Ovviamente non si tratta di un metodo "pulito", soprattuto se si vuole procedere con un "__design by testing__".



