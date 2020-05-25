import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Arrays;

public static final int boxMargin = 15;
public static final int boxHeight = 150;
public static final int numRows = 4;
public static final int buttonMargin = 10;
public static final int buttonTextShift = 7;

public static final int backgroundColor = 150;
public static final int boxColor = 190;
public static final int numpadButtonDefaultColor = 255;
public static final int numpadButtonHoverColor = 210;
public static final int numpadButtonPressedColor = 180;

public static final String CLEAR_CODE = "AC";
public static final String DELETE_CODE = "DEL";
public static final String DECIMAL_CODE = ".";
public static final String ADDITION_CODE = "+";
public static final String SUBTRACTION_CODE = "–";
public static final String MUTLIPLICATION_CODE = "×";
public static final String DIVISION_CODE = "÷";
public static final String EXPONENT_CODE = "^";
public static final String OPEN_PAREN_CODE = "(";
public static final String CLOSE_PAREN_CODE = ")";
public static final String EQUALS_CODE = "=";

public ArrayList<Button> numpadButtons;
public ArrayList<Button> operationButtons;

public String calculatorEntry = "";

public void setup()
{
  size(450,500);
}

public boolean shouldRedraw = true;

public void draw()
{
  if (shouldRedraw)
  {
    background(backgroundColor);
    drawCalculatorElements();
    shouldRedraw = false;
  }
}

public void mousePressed()
{
  for (Button numpadButton : numpadButtons)
  {
    if (numpadButton.isButtonClick(mouseX, mouseY))
    {
      numpadButton.setPressed(true);
    }
  }

  for (Button operationButton : operationButtons)
  {
    if (operationButton.isButtonClick(mouseX, mouseY))
    {
      operationButton.setPressed(true);
    }
  }
}

public void mouseReleased()
{
  for (Button numpadButton : numpadButtons)
  {
    if (numpadButton.getPressed())
    {
      numpadButton.setPressed(false);
      handleNumpadPress(numpadButton.getValue());
    }
  }

  for (Button operationButton : operationButtons)
  {
    if (operationButton.getPressed())
    {
      operationButton.setPressed(false);
      handleOperationPress(operationButton.getValue());
    }
  }
}

public void mouseMoved()
{
  for (Button numpadButton : numpadButtons)
  {
    if (numpadButton.isButtonClick(mouseX, mouseY))
    {
      numpadButton.setHover(true);
    }
    else
    {
      numpadButton.setHover(false);
    }
  }

  for (Button operationButton : operationButtons)
  {
    if (operationButton.isButtonClick(mouseX, mouseY))
    {
      operationButton.setHover(true);
    }
    else
    {
      operationButton.setHover(false);
    }
  }
}

public void keyPressed()
{
  switch (keyCode)
  {
    case 48+0:
    getButtonForValue("0").setPressed(true);
    break;

    case 48+1:
    getButtonForValue("1").setPressed(true);
    break;

    case 48+2:
    getButtonForValue("2").setPressed(true);
    break;

    case 48+3:
    getButtonForValue("3").setPressed(true);
    break;

    case 48+4:
    getButtonForValue("4").setPressed(true);
    break;

    case 48+5:
    getButtonForValue("5").setPressed(true);
    break;

    case 48+6:
    getButtonForValue("6").setPressed(true);
    break;

    case 48+7:
    getButtonForValue("7").setPressed(true);
    break;

    case 48+8:
    getButtonForValue("8").setPressed(true);
    break;

    case 48+9:
    getButtonForValue("9").setPressed(true);
    break;

    case 46:
    getButtonForValue(DECIMAL_CODE).setPressed(true);
    break;

    case 8:
    getButtonForValue(DELETE_CODE).setPressed(true);
    break;
  }
}

public void keyReleased()
{
  switch (keyCode)
  {
    case ENTER:
    case RETURN:
    executeBaseCalculation();
    break;

    case 48+0:
    getButtonForValue("0").setPressed(false);
    handleNumpadPress("0");
    break;

    case 48+1:
    getButtonForValue("1").setPressed(false);
    handleNumpadPress("1");
    break;

    case 48+2:
    getButtonForValue("2").setPressed(false);
    handleNumpadPress("2");
    break;

    case 48+3:
    getButtonForValue("3").setPressed(false);
    handleNumpadPress("3");
    break;

    case 48+4:
    getButtonForValue("4").setPressed(false);
    handleNumpadPress("4");
    break;

    case 48+5:
    getButtonForValue("5").setPressed(false);
    handleNumpadPress("5");
    break;

    case 48+6:
    getButtonForValue("6").setPressed(false);
    handleNumpadPress("6");
    break;

    case 48+7:
    getButtonForValue("7").setPressed(false);
    handleNumpadPress("7");
    break;

    case 48+8:
    getButtonForValue("8").setPressed(false);
    handleNumpadPress("8");
    break;

    case 48+9:
    getButtonForValue("9").setPressed(false);
    handleNumpadPress("9");
    break;

    case 46:
    getButtonForValue(DECIMAL_CODE).setPressed(false);
    handleNumpadPress(DECIMAL_CODE);
    break;

    case 8:
    getButtonForValue(DELETE_CODE).setPressed(false);
    handleNumpadPress(DELETE_CODE);
    break;
  }
}

public Button getButtonForValue(String value)
{
  ArrayList<Button> allButtons = new ArrayList<Button>();
  allButtons.addAll(numpadButtons);
  allButtons.addAll(operationButtons);

  for (Button button : numpadButtons)
    if (value.equals(button.getValue()))
      return button;

  return allButtons.get(0);
}

public void drawCalculatorElements()
{
  drawEntryBox();

  int rowHeight = (height-(boxMargin+boxMargin*2+boxHeight)-buttonMargin*(numRows-1)-buttonMargin*2)/numRows;
  drawNumpad(rowHeight);
  drawOperationsBox(rowHeight);
}

public void drawEntryBox()
{
  fill(boxColor);
  rect(boxMargin, boxMargin, width-boxMargin*2, boxHeight);

  fill(0);
  textAlign(LEFT);
  textSize(20);
  text(calculatorEntry, boxMargin*2, 20+boxMargin*2);
}

public void drawNumpad(int buttonSize)
{
  final int buttonRows = 4;
  final int buttonColumns = 3;
  final String[] buttonTitles = new String[]{"7", "8", "9", "4", "5", "6", "1", "2", "3", "0", DECIMAL_CODE, DELETE_CODE};

  numpadButtons = new ArrayList<Button>();

  final int numpadWidth = (buttonColumns+1)*buttonMargin+buttonColumns*buttonSize;
  final int numpadHeight = (buttonRows+1)*buttonMargin+buttonRows*buttonSize;
  fill(boxColor);
  rect(boxMargin, boxMargin*2+boxHeight, numpadWidth, numpadHeight);

  for (int i=0; i < buttonRows; i++)
  {
    for (int j=0; j < buttonColumns; j++)
    {
      numpadButtons.add(new Button(buttonTitles[i*buttonColumns+j], buttonSize, boxMargin+(j+1)*buttonMargin+j*buttonSize+buttonSize/2, boxMargin*2+boxHeight+(i+1)*buttonMargin+i*buttonSize+buttonSize/2));
    }
  }

  for (Button numpadButton : numpadButtons)
  {
    numpadButton.show();
  }
}

public void handleNumpadPress(String numpadValue)
{
  if (numpadValue.matches("-?\\d+") || numpadValue == DECIMAL_CODE)
  {
    calculatorEntry += numpadValue;
  }
  else if (numpadValue == DELETE_CODE && calculatorEntry != null && calculatorEntry.length() > 0)
  {
    calculatorEntry = calculatorEntry.substring(0, calculatorEntry.length()-1);
  }
  else if (numpadValue == CLEAR_CODE)
  {
    calculatorEntry = "";
  }

  drawEntryBox();
}

public void drawOperationsBox(int buttonSize)
{
  final int buttonRows = 4;
  final int buttonColumns = 2;
  final String[] buttonTitles = new String[]{DIVISION_CODE, EXPONENT_CODE, MUTLIPLICATION_CODE, OPEN_PAREN_CODE, SUBTRACTION_CODE, CLOSE_PAREN_CODE, ADDITION_CODE, EQUALS_CODE};

  operationButtons = new ArrayList<Button>();

  final int numpadWidth = (buttonColumns+1)*buttonMargin+buttonColumns*buttonSize;
  final int numpadHeight = (buttonRows+1)*buttonMargin+buttonRows*buttonSize;
  fill(boxColor);
  rect(width-(boxMargin+buttonMargin*(buttonColumns+1)+buttonSize*buttonColumns), boxMargin*2+boxHeight, numpadWidth, numpadHeight);

  for (int i=0; i < buttonRows; i++)
  {
    for (int j=0; j < buttonColumns; j++)
    {
      operationButtons.add(new Button(buttonTitles[i*buttonColumns+j], buttonSize, width-(boxMargin+((buttonColumns-1-j)+1)*buttonMargin+(buttonColumns-1-j)*buttonSize+buttonSize/2), boxMargin*2+boxHeight+(i+1)*buttonMargin+i*buttonSize+buttonSize/2));
    }
  }

  for (Button operationButton : operationButtons)
  {
    operationButton.show();
  }
}

public void handleOperationPress(String operationValue)
{
  calculatorEntry += operationValue;

  drawEntryBox();
}

public void executeBaseCalculation()
{
  String calculatedResult = executeCalculation(calculatorEntry);
  println(calculatedResult);
}

public String executeCalculation(String calculation)
{
  calculation = evaluateParentheses(calculation);
  calculation = performOperations(calculation, new String[]{EXPONENT_CODE});
  calculation = performOperations(calculation, new String[]{MUTLIPLICATION_CODE, DIVISION_CODE});
  calculation = performOperations(calculation, new String[]{ADDITION_CODE, SUBTRACTION_CODE});

  return calculation;
}

public String evaluateParentheses(String calculation)
{
  ArrayList<String> parentheticals = new ArrayList<String>();

  int parentheticalLevel = 0;
  int startOfCurrentParenthetical = 0;
  for (int i=0; i < calculation.length(); i++)
  {
    if (String.valueOf(calculation.charAt(i)).equals(OPEN_PAREN_CODE))
    {
      if (parentheticalLevel == 0) startOfCurrentParenthetical = i;
      parentheticalLevel++;
    }

    if (String.valueOf(calculation.charAt(i)).equals(CLOSE_PAREN_CODE))
    {
      parentheticalLevel--;
      if (parentheticalLevel == 0)
        parentheticals.add(calculation.substring(startOfCurrentParenthetical+1, i+1-1));
    }
  }

  for (String parenthetical : parentheticals)
  {
    calculation = calculation.replaceFirst("\\(" + escapeRegex(parenthetical) + "\\)", executeCalculation(parenthetical));
  }

  return calculation;
}

public String escapeRegex(String literal)
{
  return literal.replace(".", "\\.").replace("+", "\\+").replace("*", "\\*").replace("^", "\\^").replace("(", "\\(").replace(")", "\\)");
}

public String performOperations(String calculation, String[] operationsToPerform)
{
  ArrayList<String> numericalValues = getNumericalValues(calculation);
  ArrayList<String> operations = getOperations(calculation);

  //println("1--" + calculation, operations);
  if (operations.size() == 0) return calculation;

  while (!Arrays.asList(operationsToPerform).contains(operations.get(0)))
  {
    operations.remove(0);
    numericalValues.remove(0);
    if (operations.size() == 0) return calculation;
  }

  double calculatedValue = 0;
  switch (operations.get(0))
  {
    case EXPONENT_CODE:
    calculatedValue = Math.pow(Double.parseDouble(numericalValues.get(0)), Double.parseDouble(numericalValues.get(1)));
    break;

    case MUTLIPLICATION_CODE:
    calculatedValue = Double.parseDouble(numericalValues.get(0))*Double.parseDouble(numericalValues.get(1));
    break;

    case DIVISION_CODE:
    calculatedValue = Double.parseDouble(numericalValues.get(0))/Double.parseDouble(numericalValues.get(1));
    break;

    case ADDITION_CODE:
    calculatedValue = Double.parseDouble(numericalValues.get(0))+Double.parseDouble(numericalValues.get(1));
    break;

    case SUBTRACTION_CODE:
    calculatedValue = Double.parseDouble(numericalValues.get(0))-Double.parseDouble(numericalValues.get(1));
    break;
  }

  String newCalculation = calculation.replaceFirst(escapeRegex(numericalValues.get(0) + operations.get(0) + numericalValues.get(1)), String.valueOf(calculatedValue));
  println(calculation, newCalculation);
  return performOperations(newCalculation, operationsToPerform);
}

public ArrayList<String> getNumericalValues(String calculation)
{
  ArrayList<String> numericalValues = new ArrayList<String>();

  Pattern pattern = Pattern.compile("([-\\d\\.E]+)");
  Matcher matcher = pattern.matcher(calculation);
  while (matcher.find())
  {
    numericalValues.add(matcher.group());
  }

  return numericalValues;
}

public ArrayList<String> getOperations(String calculation)
{
  ArrayList<String> operations = new ArrayList<String>();

  Pattern pattern = Pattern.compile("([^-\\d\\.E]+)");
  Matcher matcher = pattern.matcher(calculation);
  while (matcher.find())
  {
    operations.add(matcher.group());
  }

  return operations;
}

public class Button
{
  private String value;
  private int size;
  private int xPos;
  private int yPos;
  private boolean isPressed = false;
  private boolean isHovering = false;

  public Button(String value, int size, int x, int y)
  {
    this.value = value;
    this.size = size;
    this.xPos = x;
    this.yPos = y;
  }

  public void show()
  {
    if (isPressed) fill(numpadButtonPressedColor);
    else if (isHovering) fill(numpadButtonHoverColor);
    else fill(numpadButtonDefaultColor);
    ellipse(xPos, yPos, size, size);
    textAlign(CENTER);
    textSize(20);
    fill(0);
    text(value, xPos, yPos+buttonTextShift);
  }

  public boolean isButtonClick(int x, int y)
  {
    return sqrt(pow((xPos-x),2)+pow((yPos-y),2)) <= size/2;
  }

  public boolean getPressed()
  {
    return isPressed;
  }

  public void setPressed(boolean pressed)
  {
    isPressed = pressed;
    show();
  }

  public void setHover(boolean hover)
  {
    if (isHovering == hover) return;
    isHovering = hover;
    show();
  }

  public String getValue()
  {
    return value;
  }
}
