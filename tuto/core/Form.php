<?php
 class Form{

   public $controller;

   public function __construct($controller){
     $this->controller = $controller;
   }

   public function input($name, $label, $options = array()){
     if($label == 'hidden'){
       return '<input type="hidden" name="'.$name.'" value="'.$this->controller->request->data->$name.'">';
     }
     $html = '<div class="form-group row">
                <label for="input'.$name.'" class="col-sm-2 col-form-label">'.$label.'</label>
                <div class="col-sm-10">';
      $attr = ' ';
      foreach($options as $k=>$v){
        if($k!='type'){
          $attr .= " $k=\"$v\"";
        }
      }
      if(!isset($options['type'])){
        $html .= '<input type="text" id="input'.$name.'" name="'.$name.'" value="'.$this->controller->request->data->$name.'"'.$attr.'>';
      }elseif($options['type'] == 'textarea'){
        $html .= '<textarea id="input'.$name.'" name="'.$name.'"'.$attr.'>'.$this->controller->request->data->$name.'</textarea>';
      }elseif($options['type'] == 'checkbox'){
        $html .= '<input type="hidden" name="'.$name.'" value="0"><input type="checkbox" name="'.$name.'" value="1">';
      }
      $html.='</div></div>';
      return $html;
   }
 }
?>
