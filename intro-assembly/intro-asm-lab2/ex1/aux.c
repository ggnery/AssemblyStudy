char str[] = "BEBAMUITOCAFE";



void process()

{

	char *ptr = str;

	while (*ptr) {

	// Seu código aqui...
		*ptr = *ptr - 'A' +  'a';
		ptr++;
	}

}
