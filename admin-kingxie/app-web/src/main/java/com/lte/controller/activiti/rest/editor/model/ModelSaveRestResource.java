package com.lte.controller.activiti.rest.editor.model;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.springframework.web.bind.annotation.RestController;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.persistence.entity.ModelEntity;
import org.activiti.engine.repository.Model;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
/**
 * Created by think on 2016/12/28.
 */
@RestController
public class ModelSaveRestResource implements ModelDataJsonConstants {
    protected static final Logger LOGGER = LoggerFactory.getLogger(ModelSaveRestResource.class);

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private ObjectMapper objectMapper;

    @RequestMapping(value="/model/{modelId}/save", method = RequestMethod.PUT)
    @ResponseStatus(value = HttpStatus.OK)
    public void saveModel(@PathVariable String modelId, @RequestBody MultiValueMap<String, String> values) {
        try {

            Model model = repositoryService.getModel(modelId);

            ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());

            modelJson.put(MODEL_NAME, values.getFirst("name"));
            modelJson.put(MODEL_DESCRIPTION, values.getFirst("description"));
            model.setMetaInfo(modelJson.toString());
            model.setName(values.getFirst("name"));

            repositoryService.saveModel(model);

            repositoryService.addModelEditorSource(model.getId(), values.getFirst("json_xml").getBytes("utf-8"));

            InputStream svgStream = new ByteArrayInputStream(values.getFirst("svg_xml").getBytes("utf-8"));
            TranscoderInput input = new TranscoderInput(svgStream);

            PNGTranscoder transcoder = new PNGTranscoder();
            // Setup output
            ByteArrayOutputStream outStream = new ByteArrayOutputStream();
            TranscoderOutput output = new TranscoderOutput(outStream);

            // Do the transformation
            transcoder.transcode(input, output);
            final byte[] result = outStream.toByteArray();
            repositoryService.addModelEditorSourceExtra(model.getId(), result);
            outStream.close();

        } catch (Exception e) {
            //   LOGGER.error("Error saving model", e);
            throw new ActivitiException("Error saving model", e);
        }
    }

    @RequestMapping(value="/model/new", method = RequestMethod.GET)
    @ResponseStatus(value = HttpStatus.OK)
    public String addModel(@RequestParam(defaultValue="测试") String name,@RequestParam(defaultValue="testkey") String key, @RequestParam(defaultValue="测试练习") String description,HttpServletRequest request) {
        String url = "";
        try {
            //保存模型
            Model model = new ModelEntity();
            model.setName(name);
            model.setKey(key);
            //    model.setVersion(1);
            ObjectNode modelJson = (ObjectNode) objectMapper.readTree("{}");
            modelJson.put(MODEL_NAME, model.getName());
            modelJson.put(MODEL_DESCRIPTION, description);
            model.setMetaInfo(modelJson.toString());
            repositoryService.saveModel(model);

            //保存模型资源
            repositoryService.addModelEditorSource(model.getId(), ("{\"resourceId\":\""+model.getId()+"\",\"properties\":{\"process_id\":\""+key+"\",\"name\":\""+name+"\",\"documentation\":\""+description+"\",\"process_author\":\"\",\"process_version\":\"\",\"process_namespace\":\"http://www.activiti.org/processdef\",\"executionlisteners\":\"\",\"eventlisteners\":\"\",\"signaldefinitions\":\"\",\"messagedefinitions\":\"\"},\"stencil\":{\"id\":\"BPMNDiagram\"},\"childShapes\":[],\"bounds\":{\"lowerRight\":{\"x\":1200,\"y\":1050},\"upperLeft\":{\"x\":0,\"y\":0}},\"stencilset\":{\"url\":\"stencilsets/bpmn2.0/bpmn2.0.json\",\"namespace\":\"http://b3mn.org/stencilset/bpmn2.0#\"},\"ssextensions\":[]}").getBytes("utf-8"));

            InputStream svgStream = new ByteArrayInputStream("<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:oryx=\"http://oryx-editor.org\"  width=\"50\" height=\"50\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:svg=\"http://www.w3.org/2000/svg\"><defs/><svg id=\"underlay-container\"/><g stroke=\"none\" font-family=\"Verdana, sans-serif\" font-size-adjust=\"none\" font-style=\"normal\" font-variant=\"normal\" font-weight=\"normal\" line-heigth=\"normal\" font-size=\"12\"><g class=\"stencils\"><g class=\"me\"/><g class=\"children\"/><g class=\"edge\"/></g><g class=\"svgcontainer\"><g display=\"none\"><rect x=\"0\" y=\"0\" stroke-width=\"1\" stroke=\"#777777\" fill=\"none\" stroke-dasharray=\"2,2\" pointer-events=\"none\"/></g><g display=\"none\"><path stroke-width=\"1\" stroke=\"silver\" fill=\"none\" stroke-dasharray=\"5,5\" pointer-events=\"none\"/></g><g display=\"none\"><path stroke-width=\"1\" stroke=\"silver\" fill=\"none\" stroke-dasharray=\"5,5\" pointer-events=\"none\"/></g><g/></g></g></svg>".getBytes("utf-8"));
            TranscoderInput input = new TranscoderInput(svgStream);

            PNGTranscoder transcoder = new PNGTranscoder();
            // Setup output
            ByteArrayOutputStream outStream = new ByteArrayOutputStream();
            TranscoderOutput output = new TranscoderOutput(outStream);

            // Do the transformation
            transcoder.transcode(input, output);
            final byte[] result = outStream.toByteArray();
            repositoryService.addModelEditorSourceExtra(model.getId(), result);
            outStream.close();
            url = "http://127.0.0.1:"+request.getLocalPort()+request.getContextPath()+"/bpm/modeler.html?modelId="+model.getId();
            url = "<a href='"+url+"' target='_blank'>"+url+"</a>";
        } catch (Exception e) {
            LOGGER.error("Error saving model", e);
            throw new ActivitiException("Error saving model", e);
        }
        return url;
    }
}
