import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import okhttp3.*;

import java.io.*;
import java.util.concurrent.TimeUnit;

/**
 * @Author zjh
 * @Date 2022-11-14 下午 7:18
 **/
public class main {

    public static final String API_KEY = "";
    public static final String SECRET_KEY = "";

    static final OkHttpClient HTTP_CLIENT = new OkHttpClient().newBuilder().
            connectTimeout(10, TimeUnit.SECONDS)  // 连接超时时间
            .readTimeout(30, TimeUnit.SECONDS)     // 读取超时时间
            .writeTimeout(10, TimeUnit.SECONDS)    // 写入超时时间
            .build();

    public static void main(String[] args) throws IOException {
        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, "{\"messages\":[{\"role\":\"user\",\"content\":\"推荐几本书，我心情不好\"}],\"system\":\"模型人设名称： 拾柒助手  角色定位： 拾柒助手是拾柒爱阅读系统中的智能客服，专为读者提供书籍推荐和分享高质量书评服务。它能够从庞大的书籍数据库中筛选出合适的书籍，并通过简洁明了的链接方式，帮助用户快速定位到心仪的读物。  外观描述： 虽然拾柒助手没有具体的物理形态，但它以文字的形式呈现，界面简洁清晰，方便用户与其进行交互。  个性与动机： 拾柒助手性格温和而富有耐心，它始终以用户的阅读需求为出发点，希望能够帮助用户找到心仪的书籍，享受阅读的乐趣。它的动机是不断提升服务质量，让每一位用户都能感受到阅读的魅力。  技能与能力： 拾柒助手拥有强大的数据处理和智能分析能力，能够根据用户的阅读历史和偏好，快速生成个性化的书籍推荐。同时，它还能够提供深入而客观的书评，帮助用户更好地了解书籍的内容和风格。  背景故事： 在拾柒爱阅读系统的开发过程中，拾柒助手应运而生。它结合了先进的自然语言处理技术和阅读领域的专业知识，经过不断的优化和升级，逐渐成为了用户心中值得信赖的阅读伙伴。  互动表现： 当用户向拾柒助手询问书籍推荐时，它会仔细聆听用户的需求，并从数据库中筛选出合适的书籍。随后，它会以简洁明了的超链接形式，为用户提供书籍的详细信息。例如：“根据您的喜好，我为您推荐了这本《解忧杂货店》，点击这里[http://airead/book/xxx]即可了解更多。”同时，如果用户想要了解某本书的书评，拾柒助手也会迅速提供相关的评价和解析。  与其他角色的关系： 在拾柒爱阅读系统中，拾柒助手与其他组件保持着良好的合作关系。它与其他角色共同为用户提供全方位的阅读服务，共同营造一个良好的阅读环境。  台词与语言风格： 拾柒助手的台词亲切自然，语言风格简洁明了。它总是以礼貌和尊重的态度与用户交流，让用户感受到温暖和关怀。例如：“您好，我是拾柒助手，很高兴能为您提供帮助。请问您有什么阅读需求吗？我会尽力为您推荐合适的书籍。”\",\"disable_search\":false,\"enable_citation\":false}");
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions_pro?access_token=" + getAccessToken())
                .method("POST", body)
                .addHeader("Content-Type", "application/json")
                .build();
        Response response = HTTP_CLIENT.newCall(request).execute();
        System.out.println(response.body().string());
    }

    /**
     * 从用户的AK，SK生成鉴权签名（Access Token）
     *
     * @return 鉴权签名（Access Token）
     * @throws IOException IO异常
     */
    static String getAccessToken() throws IOException {
        MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
        RequestBody body = RequestBody.create(mediaType, "grant_type=client_credentials&client_id=" + API_KEY
                + "&client_secret=" + SECRET_KEY);
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/oauth/2.0/token")
                .method("POST", body)
                .addHeader("Content-Type", "application/x-www-form-urlencoded")
                .build();
        Response response = HTTP_CLIENT.newCall(request).execute();
        // 解析响应体为字符串
        String responseBody = response.body().string();

        // 使用fastjson将字符串解析为JSONObject
        JSONObject jsonObject = JSON.parseObject(responseBody);

        // 从JSONObject中提取访问令牌
        return jsonObject.getString("access_token");
    }
}
