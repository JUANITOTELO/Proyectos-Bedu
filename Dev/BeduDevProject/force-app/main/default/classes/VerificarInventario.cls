public class VerificarInventario {
    public VerificarInventario(List<Quote> quo){
        for(Quote newQ : quo){
            if(newQ.Status == 'Approved' || newQ.Status == 'Accepted'){
                quo[0].addError('La cotización aun no tiene productos, cambie el estado para guardar.');
                break;
            }
        }
    }
}