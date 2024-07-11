import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SozlesmeScreen extends StatelessWidget {
  const SozlesmeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.onSecondary),
                    width: 60.w,
                    height: 5.h,
                  ),
                )
              ],
            ),
            Container(
              height: 300.h,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: HtmlWidget(
                      onTapUrl: (p0) {
                        print(p0);
                        Navigator.pop(context);
                        return true;
                      },
                      // the first parameter (`html`) is required
                      '''
                       
                      <html class="translated-ltr"><head><link type="text/css" rel="stylesheet" charset="UTF-8" href="https://www.gstatic.com/_/translate_http/_/ss/k=translate_http.tr.26tY-h6gH9w.L.W.O/am=wA/d=0/rs=AN8SPfpPTNr3cQN8QhzqvQYsNrDu3oHhow/m=el_main_css"></head><body><h1><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Gizlilik Politikası</font></font></h1>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Son güncelleme: 26 Nisan 2024</font></font></p>
                      <h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Yorum ve Tanımlar</font></font></h2>
                      <h3><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Tercüme</font></font></h3>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Baş harfi büyük olan kelimeler aşağıdaki şartlarda tanımlanan anlamlara sahiptir. Aşağıdaki tanımlar tekil veya çoğul olmasına bakılmaksızın aynı anlama gelecektir.</font></font></p>
                      <h3><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Tanımlar</font></font></h3>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Bu Gizlilik Politikasının amaçları doğrultusunda:</font></font></p>
                      <ul>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hesap,</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Hizmetimize veya Hizmetimizin bölümlerine erişmeniz için oluşturulan benzersiz bir hesap anlamına gelir.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Bağlı kuruluş,</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> bir tarafı kontrol eden, onun tarafından kontrol edilen veya bir tarafla ortak kontrol altında olan bir kuruluş anlamına gelir; burada "kontrol", yöneticilerin veya diğer yönetim otoritesinin seçimi için oy kullanma hakkına sahip hisselerin, öz sermaye paylarının veya diğer menkul kıymetlerin %50 veya daha fazlasının mülkiyeti anlamına gelir .</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Uygulama</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> , Şirket tarafından sağlanan yazılım programı olan SALONMATE'i ifade etmektedir.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Şirket</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> (bu Sözleşmede "Şirket", "Biz", "Bize" veya "Bizim" olarak anılacaktır), Arsel Kozmetik San. İç ve Dış Tic. Ltd. Şti., Çınar Mh. Yukarı Tahsin Bey Sokak No:11/28 Küçükyalı Maltepe İstanbul.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Ülke</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> şunu ifade eder: Türkiye</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Cihaz,</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Hizmete erişebilen bilgisayar, cep telefonu veya dijital tablet gibi herhangi bir cihaz anlamına gelir.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kişisel Veri, kimliği</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> belirli veya belirlenebilir bir kişiye ilişkin her türlü bilgidir.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmet,</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Uygulamayı ifade eder.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmet Sağlayıcı,</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Şirket adına verileri işleyen gerçek veya tüzel kişiyi ifade eder. Hizmeti kolaylaştırmak, Şirket adına Hizmeti sağlamak, Hizmetle ilgili hizmetleri gerçekleştirmek veya Şirkete Hizmetin nasıl kullanıldığını analiz etmede yardımcı olmak için Şirket tarafından istihdam edilen üçüncü taraf şirketleri veya kişileri ifade eder.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kullanım Verileri,</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Hizmetin kullanımıyla veya Hizmet altyapısının kendisinden otomatik olarak toplanan verileri (örneğin, bir sayfa ziyaretinin süresi) ifade eder.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmete erişen veya Hizmeti kullanan bireyi veya söz konusu kişinin adına Hizmete erişen veya Hizmeti kullanan şirketi veya diğer tüzel kişiyi ifade edersiniz </font><strong><font style="vertical-align: inherit;">.</font></strong></font></p>
                      </li>
                      </ul>
                      <h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kişisel Verilerinizin Toplanması ve Kullanılması</font></font></h2>
                      <h3><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Toplanan Veri Türleri</font></font></h3>
                      <h4><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kişisel veri</font></font></h4>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmetimizi kullanırken, Sizinle iletişime geçmek veya kimliğinizi belirlemek için kullanılabilecek belirli kişisel bilgileri Bize sağlamanızı isteyebiliriz. Kişisel olarak tanımlanabilir bilgiler aşağıdakileri içerebilir ancak bunlarla sınırlı değildir:</font></font></p>
                      <ul>
                      <li>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Ad ve soyad</font></font></p>
                      </li>
                      <li>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Telefon numarası</font></font></p>
                      </li>
                      <li>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kullanım verisi</font></font></p>
                      </li>
                      </ul>
                      <h4><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kullanım verisi</font></font></h4>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kullanım Verileri, Hizmet kullanılırken otomatik olarak toplanır.</font></font></p>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kullanım Verileri, Cihazınızın İnternet Protokol adresi (örn. IP adresi), tarayıcı türü, tarayıcı sürümü, Hizmetimizin ziyaret ettiğiniz sayfaları, ziyaretinizin saati ve tarihi, bu sayfalarda geçirilen süre, benzersiz cihaz gibi bilgileri içerebilir. tanımlayıcılar ve diğer teşhis verileri.</font></font></p>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmete bir mobil cihaz üzerinden veya aracılığıyla eriştiğinizde, kullandığınız mobil cihazın türü, mobil cihazınızın benzersiz kimliği, mobil cihazınızın IP adresi, cep telefonunuz dahil ancak bunlarla sınırlı olmamak üzere belirli bilgileri otomatik olarak toplayabiliriz. işletim sistemi, kullandığınız mobil İnternet tarayıcısının türü, benzersiz cihaz tanımlayıcıları ve diğer teşhis verileri.</font></font></p>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Ayrıca, Hizmetimizi her ziyaret ettiğinizde veya Hizmete bir mobil cihaz üzerinden veya aracılığıyla eriştiğinizde tarayıcınızın gönderdiği bilgileri de toplayabiliriz.</font></font></p>
                      <h3><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kişisel Verilerinizin Kullanımı</font></font></h3>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Şirket, Kişisel Verileri aşağıdaki amaçlarla kullanabilir:</font></font></p>
                      <ul>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmetimizin kullanımını izlemek de dahil olmak üzere </font><strong><font style="vertical-align: inherit;">Hizmetimizi sağlamak ve sürdürmek .</font></strong></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hesabınızı yönetmek için:</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Hizmetin kullanıcısı olarak kaydınızı yönetmek için. Sağladığınız Kişisel Veriler, kayıtlı bir kullanıcı olarak Hizmetin size sunulan farklı işlevlerine erişmenizi sağlayabilir.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Bir sözleşmenin yerine getirilmesi için:</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> satın aldığınız ürün, kalem veya hizmetlere ilişkin satın alma sözleşmesinin veya Hizmet aracılığıyla Bizimle herhangi bir başka sözleşmenin geliştirilmesi, uyumluluğu ve üstlenilmesi.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Sizinle iletişime geçmek için:</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Sizinle e-posta, telefon aramaları, SMS veya mobil uygulamanın güncellemelere ilişkin anlık bildirimleri veya güvenlik güncellemeleri de dahil olmak üzere işlevler, ürünler veya sözleşmeli hizmetlerle ilgili bilgilendirici iletişimler gibi diğer eşdeğer elektronik iletişim biçimleri aracılığıyla iletişim kurmak, uygulanması için gerekli veya makul olduğunda.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Bu tür bilgileri almamayı tercih etmediğiniz sürece, size daha önce satın aldığınız veya hakkında bilgi aldığınız ürünlere benzer, sunduğumuz diğer ürünler, hizmetler ve etkinlikler hakkında </font><strong><font style="vertical-align: inherit;">size haberler, özel teklifler ve genel bilgiler sağlamak .</font></strong></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Taleplerinizi yönetmek için:</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Bize yönelik taleplerinize katılmak ve bunları yönetmek.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Ticari transferler için:</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Bilgilerinizi, devam eden bir işletme olarak veya iflas, tasfiye, veya Hizmet kullanıcılarımız hakkında tarafımızca tutulan Kişisel Verilerin devredilen varlıklar arasında yer aldığı benzer bir işlem.</font></font></p>
                      </li>
                      <li>
                      <p><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Diğer amaçlar için</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> : Bilgilerinizi veri analizi, kullanım eğilimlerini belirlemek, promosyon kampanyalarımızın etkinliğini belirlemek ve Hizmetimizi, ürünlerimizi, hizmetlerimizi, pazarlamamızı ve deneyiminizi değerlendirmek ve geliştirmek gibi başka amaçlarla da kullanabiliriz.</font></font></p>
                      </li>
                      </ul>
                      <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kişisel bilgilerinizi aşağıdaki durumlarda paylaşabiliriz:</font></font></p>
                      <ul>
                      <li><strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Hizmet Sağlayıcılarla:</font></font></strong><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> Kişisel bilgilerinizi, Hizmetimizin kullanımını izlemek ve analiz etmek, Sizinle iletişime geçmek için Hizmet Sağlayıcılarla paylaşabiliriz.</font></font></li>
                      <li><strong>For business transfers:</strong> We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.</li>
                      <li><strong>With Affiliates:</strong> We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.</li>
                      <li><strong>With business partners:</strong> We may share Your information with Our business partners to offer You certain products, services or promotions.</li>
                      <li><strong>With other users:</strong> when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.</li>
                      <li><strong>With Your consent</strong>: We may disclose Your personal information for any other purpose with Your consent.</li>
                      </ul>
                      <h3>Retention of Your Personal Data</h3>
                      <p>The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.</p>
                      <p>The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.</p>
                      <h3>Transfer of Your Personal Data</h3>
                      <p>Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.</p>
                      <p>Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.</p>
                      <p>The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.</p>
                      <h3>Delete Your Personal Data</h3>
                      <p>You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.</p>
                      <p>Our Service may give You the ability to delete certain information about You from within the Service.</p>
                      <p>You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.</p>
                      <p>Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.</p>
                      <h3>Disclosure of Your Personal Data</h3>
                      <h4>Business Transactions</h4>
                      <p>If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.</p>
                      <h4>Law enforcement</h4>
                      <p>Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).</p>
                      <h4>Other legal requirements</h4>
                      <p>The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:</p>
                      <ul>
                      <li>Comply with a legal obligation</li>
                      <li>Protect and defend the rights or property of the Company</li>
                      <li>Prevent or investigate possible wrongdoing in connection with the Service</li>
                      <li>Protect the personal safety of Users of the Service or the public</li>
                      <li>Protect against legal liability</li>
                      </ul>
                      <h3>Security of Your Personal Data</h3>
                      <p>The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.</p>
                      <h2>Children's Privacy</h2>
                      <p>Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.</p>
                      <p>If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.</p>
                      <h2>Links to Other Websites</h2>
                      <p>Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.</p>
                      <p>We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.</p>
                      <h2>Changes to this Privacy Policy</h2>
                      <p>We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.</p>
                      <p>We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.</p>
                      <p>You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.</p>
                      <h2>Contact Us</h2>
                      <p>If you have any questions about this Privacy Policy, You can contact us:</p>
                       <li>By email: info@salonmate.co</li>
                      </ul></body></html>
            
                      <a href = "DSAFDSA"><h3>Okudum Anladım Kabul Ettim</h3></a>
              ''',

                      // all other parameters are optional, a few notable params:

                      // specify custom styling for an element
                      // see supported inline styling below
                      customStylesBuilder: (element) {
                        if (element.classes.contains('foo')) {
                          return {'color': 'red'};
                        }

                        return null;
                      },

                      customWidgetBuilder: (element) {
                        return null;
                      },

                      // select the render mode for HTML body
                      // by default, a simple `Column` is rendered
                      // consider using `ListView` or `SliverList` for better performance
                      renderMode: RenderMode.column,

                      // set the default styling for text
                      textStyle: TextStyle(fontSize: 14),
                    ),
                  )),
            ),
          ],
        )));
  }
}
