# CLARA 
_Convo-Net Learning for Awake Rodent-MRI Analysis_

Alexander Laurence (alexander.adamlaurence@gmail.com)

CLARA is an AI-driven tool to visually inspect for BOLD-signal intensity dropouts in awake rodent fMRI slices. Essentially you input NIfTI files, run the image classifier, and recieve a list of noisy slices.

## Inspiration
Rodent MRI is a powerful model for preclinical research exploring physiology, pathology and drug development. Particularly, awake rodent functional MRI can allow us to assess concious changes in brain activity across different mental states. However, without anaesthesia, head movement and long interscan intervals can contribute to occasional signal dropout. As such, this can lead to image quality inconsistency as shown in the reduction of grey value intensity. 

![alt text](https://imgur.com/lGOTyCL.png)

## What it does
By detecting the images with a sudden reduced intensity (i.e. dark images) in the BOLD signal, CLARA aims to repair potential dropouts that may confound the blood oxygen level dependent signals. The goal of this tool is to develop an objective method of defining and detecting signal dropout as dark slices in the effort to repair affected volumes. 

![alt text](https://imgur.com/KSatZrQ.png)
(Laurence et al., unpublished)

CLARA provides rodent fMRI pre-clinical studies with a pipeline for automatically detecting signal dropout in the form of dark slices. Through this approach, overall consistency of image quality may improve translational validity for researchers.

## How I built it
### Dataset
We scanned the brains of two groups of healthy male adult rats (n=24). The functional images were acquired by a 7-T scanner using a Fast Spin Echo sequence of a 64x64 matrix, TR=2500ms, ETL 16, and effective TE=36ms. 

Two experimenters inspected signal dropout at the coronal slices which could also be seen as dark bands in the axial and sagittal views. To provide an objective measurement, mean image intensity was calculated by using ImageJ. Subjective inspection from two experimenters shows highly consistent identification of dark images. Using the image intensity data, we plotted the distribution and established a threshold of detecting the dark images. We defined a threshold that best matching the subjective inspection and formed objective criteria that could be applied across datasets. 

### Prediction
The model (RatNet) is built using Keras, utilizing TensorFlow as the backend. TensorFlow was chosen as the backend due to better performance over Theano, and the ability to visualize the neural network using TensorBoard.

For predicting two categories (good/bad), our model utilizes three convolutional layers, each having a depth of 32. A Max Pooling layer is applied after all three convolutional layers with size (2,2).

After pooling, the data is fed through a single fully connected layer of size 128, and finally to the output layer, consisting of 2 softmax nodes.

![alt text](https://camo.githubusercontent.com/7c4023519dabde95b1accdd7dfbd38e13cd7daa2/68747470733a2f2f692e696d6775722e636f6d2f744179664237322e706e67)

## Challenges I ran into
Building a custom medical image training data net (RatNet). This was not so easy, as I had to painstakingly categorise 30,000 images as either 'good' or 'bad'.

## Accomplishments that I'm proud of
I'm proud that I have learnt Deep Learning while taking part in this project, and applied it to a real world setting in which researchers and medical staff can make use of.

## What I learned
Learning Deep Learning while building this tool.

## What's next for CLARA
* 4D time-series fMRI data support. Currenly only supports 3D (or 4D-segmented data).
* Program the neural network to retrain with new photos. This is a common practice, and only serves to optimize the model. Checks would be put in place to validate the images before being added to the classifier, in order to prevent low quality images from altering the classifier too drastically.
* Port the Keras model to CoreML, and deploy to an RatNet iOS application. CoreML is a framework designed by Apple for adding machine learning to iOS devices. This allows the ability of Python developers to export their models, convert the file to a .mlmodel file, and add the file to the iOS development cycle.
