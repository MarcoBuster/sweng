# Riepilogo

La tabella sottostante fornisce un riepilogo di ciò che rappresenta ciascuna variante dei Test Double.

<table class="border">
    <tr>
        <td style="width: 15%!important"><b>Test Double</b></td>
        <td style="width: 20%!important"><b>Purpose</b></td>
        <td><b>Has behavior?</b></td>
        <td style="width: 20%!important"><b>Injects Indirect <br>Inputs into SUT</b></td>
        <td style="width: 20%!important"><b>Handles Indirect <br>Outputs of SUT</b></td>
        <td style="width: 15%!important"><b>Values Provided <br>by Test(er)</b></td>
    </tr>
    <tr>
        <td>Dummy Object</td>
        <td>Utilizzato come segnaposto quando è necessario passare un argomento a un metodo</td>
        <td>NO</td>
        <td>NO, mai usato</td>
        <td>NO, mai usato</td>
        <td>Nessuno</td>
    </tr>
    <tr>
        <td>Stub Object</td>
        <td>Fornisce risposte preconfezionate alle sole chiamate fatte durante il testing</td>
        <td>SI</td>
        <td>SI</td>
        <td>NO, li ignora</td>
        <td>Input indiretti per il SUT</td>
    </tr>
    <tr>
        <td>Mock Object</td>
        <td>Instrumentare e controllare le chiamate</td>
        <td>SI</td>
        <td>Opzionale</td>
        <td>Verifica la correttezza rispetto alle aspettative.</td>
        <td>Input indiretti per il SUT (opzionali) e output indiretti attesi dal SUT</td>
    </tr>
    <tr>
        <td>Spy Object</td>
        <td>Instrumentare e controllare le chiamate a oggetti reali</td>
        <td>SI</td>
        <td>Opzionale</td>
        <td>Li cattura per una verifica successiva</td>
        <td>Input indiretti per il SUT (opzionali)</td>
    </tr>
    <tr>
        <td>Fake Object</td>
        <td>Permette di eseguire test che altrimenti sarebbero impossibili o avrebbero effetti collaterali indesiderati (es test molto lenti)</td>
        <td>SI</td>
        <td>NO</td>
        <td>Li utilizza</td>
        <td>Nessuno</td>
    </tr>
</table>