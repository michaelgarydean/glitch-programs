import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class sonifyFile {

	public static void main(String[] args) throws IOException, WavFileException {
		String input, output;
		input = "youtube.html";
		output = "youtube.wav";
		
		writeAudio(output, readFile(input));
	} //end main
	
	static double [] readFile(String filename) throws IOException {
		//initialize variables and objects
		int fileLength;
		char [] content;
		double [] samples;
		File file;
		FileReader reader;
		
		//create new File and FileReader objects for reading text file
		file = new File(filename);
		reader = new FileReader(file);
		
		fileLength = (int) file.length();		//get number of characters (bytes) in text file
		content = new char[fileLength];			//create array to store content read from file
		reader.read(content);					//read content of text file to the array
		
		//close the FileReader
		reader.close();
		
		//convert ASCII characters to doubles [-1.0, 1.0]
		samples = convertCharToDouble(content);
		
		return samples;
	} //end readFile method
	
	static void writeAudio(String outputName, double [] samples) throws IOException, WavFileException {
		//initialize variables
		int sr = 48000;							// Samples per second = sample rate
		int numChannels = 1;					// number of channels in audio file. 1=mono, 2=stereo etc...
		int bitDepth = 24;						// number of bits used to represent sample amplitudes
		int numFrames = samples.length;			// number of frames for specified duration
		
		//initialize objects
		WavFile wavFile;

		// Create a wav file with the name specified as the first argument
		wavFile = WavFile.newWavFile(new File(outputName), numChannels, numFrames, bitDepth, sr);

		// Write the buffer
		wavFile.writeFrames(samples, numFrames);

		// Close the wavFile
		wavFile.close();
	} //end writeAudio method
	
	static double [] convertCharToDouble(char [] textContent) {
		//initialize variables
		double [] dbls = new double[textContent.length];
		int index;
		double max=0;
		
		//convert from char to doubles
		for (index=0; index<textContent.length; index++) {
			dbls[index] = (double) textContent[index];
			
			//get maximum value
			if (dbls[index]>max) {
				max = dbls[index];
			} //end if
		} //end conversion loop
		
		//normalize values
		for (index=0; index<dbls.length; index++) {
			dbls[index] = dbls[index]/max; 	//normalize between [0.0, 1.0]
			dbls[index] = dbls[index]*2-1;	//convert to [-1.0, 1.0]
		} //end normalization loop
		
		return dbls;
	}
	
} //end class
