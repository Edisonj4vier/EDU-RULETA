import {
  IsArray,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { CreateAnswerDto } from './create-answer.dto';

export class CreateQuestionDto {
  @ApiProperty({
    description: 'Enunciado de la pregunta',
    example: '¿Cuál es la capital de Francia?',
  })
  @IsString()
  @MinLength(3)
  enunciado: string;

  @ApiProperty({
    description: 'URL del video explicativo asociado a la pregunta (opcional)',
    example: 'https://example.com/video.mp4',
    required: false,
  })
  @IsString()
  @MinLength(20)
  @IsOptional()
  url_video_explicativo?: string;

  @ApiProperty({
    description: 'Identificador del tema al que pertenece la pregunta',
    example: 'a2b3c4d5-6e7f-8g9h-10i1-j2k3l4m5n6o7',
  })
  @IsUUID()
  topic_id: string;

  @ApiProperty({
    description: 'Lista de respuestas asociadas a la pregunta',
    type: [CreateAnswerDto],
  })
  @IsArray()
  answers: CreateAnswerDto[];
}
