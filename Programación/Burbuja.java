package metodosOrdenacion;

public class Burbuja {
	
	
	public static void burbujaDescendente (int[] array){
	int i, j,aux=0;
	for (i=0 ; i< array.length -1 ; i++) {
		for (j = array.length -1 ; j > i ; j--) {
			if (array[j] > array[j-1]) {
					//intercambio de elementos
				aux = array[j];
				array[j] = array[j-1];
				array[j-1] = aux;
			}
			}
				
		}
	}
	public static void burbujaAscedente (int[] array){
		int i, j,aux=0;
		for (i=0 ; i< array.length -1 ; i++) {
			for (j = array.length -1 ; j > i ; j--) {
				if (array[j] < array[j-1]) {
						//intercambio de elementos
					aux = array[j];
					array[j] = array[j-1];
					array[j-1] = aux;
				}
				}
					
			}
		}


}
