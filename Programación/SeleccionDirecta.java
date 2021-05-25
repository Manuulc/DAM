package metodosOrdenacion;

public class SeleccionDirecta {
	public static void SeleccionDirectaAscendente (int array[], int tam) {
	int i, j, MINIMO,aux;
		for (i= 0; i<tam;i++) {
			MINIMO = i; //bucle para encontrar el elemento más pequeño
			for (j=i+1; j<tam;j++) {
				if(array[j] < array[MINIMO]) {
					MINIMO = j;
				}
			}
		//intercambio para poner en su lugar el más pequeño
			aux = array[i];
			array[i] = array[MINIMO];
			array[MINIMO] = aux;
		}
	}
	
	public static void SeleccionDirectaDescendente (int array[], int tam) {
		int i, j, MINIMO,aux;
			for (i= 0; i<tam;i++) {
				MINIMO = i; //bucle para encontrar el elemento más pequeño
				for (j=i+1; j<tam;j++) {
					if(array[j] > array[MINIMO]) {
						MINIMO = j;
					}
				}
			//intercambio para poner en su lugar el más pequeño
				aux = array[i];
				array[i] = array[MINIMO];
				array[MINIMO] = aux;
			}
		}

}
