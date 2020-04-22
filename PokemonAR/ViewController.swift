//
//  ViewController.swift
//  PokemonAR
//
//  Created by Veldanov, Anton on 4/20/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import SceneKit
import ARKit




class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
      // Bundle - location of the current file
      if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "PokemonCards", bundle: Bundle.main){
        configuration.trackingImages = imageToTrack
        configuration.maximumNumberOfTrackedImages = 1
        print("Images added!!")
      }
      
      
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
  
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    let node = SCNNode()
    
    if let imageAnchor = anchor as? ARImageAnchor{
      // create a plane using the image
      let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
      
      plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.8)
      
      
      let planeNode = SCNNode(geometry: plane)
      
      planeNode.eulerAngles.x = -.pi/2
      
      node.addChildNode(planeNode)
      
      
     if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn"){
      
      if let pokeNode = pokeScene.rootNode.childNodes.first{
        
        
        pokeNode.eulerAngles.x = .pi/2

        planeNode.addChildNode(pokeNode)
        
      }
      
      }
      
      
    }
    
    
    
    return node
  }
  
  

}
