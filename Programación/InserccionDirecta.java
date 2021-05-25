package metodosOrdenacion;

public class InserccionDirecta {
	
	public static void InserccionDirectaAscendente(int array [], int tam) {
	int i, j,aux;
		for (i=1 ;i<tam;i++) {
			for (j=i; j>0 && array[j-1]>array[j]  ; j--) {
	//intercambio de elementos
				aux = array[j];
				array[j] = array[j-1];
				array[j-1] = aux;
			}
		}
	}
	public static void InserccionDirectaDescendente(int array [], int tam) {
		int i, j,aux;
			for (i=1 ;i<tam;i++) {
				for (j=i; j>0 && array[j-1]<array[j]  ; j--) {
		//intercambio de elementos
					aux = array[j];
					array[j] = array[j-1];
					array[j-1] = aux;
				}
			}
	}

}
